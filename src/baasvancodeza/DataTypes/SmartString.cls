/// String Datatype with validation and cleanup configurations
Class baasvancodeza.DataTypes.SmartString Extends %Library.String [ ClientDataType = VARCHAR, OdbcType = VARCHAR, SqlCategory = STRING, System = 1 ]
{

/// Set PATTERN to empty and final as it is not relevant on
/// this type, but is inherited from <class>%Library.String</class>
Parameter PATTERN [ Final, Internal ];

/// Set VALUELIST to empty and final as it is not relevant on
/// this type, but is inherited from <class>%Library.String</class>
Parameter VALUELIST [ Final, Internal ];

/// Set DISPLAYLIST to empty and final as it is not relevant on
/// this type, but is inherited from <class>%Library.String</class>
Parameter DISPLAYLIST [ Final, Internal ];

/// Set whether the <a href="#REGEX">REGEX</a> parameter is a literal value
/// or if it references a global containing the regular expression.<br>
/// Values are &quot;globalref&quot; when it refers to a global, and 
/// &quot;literal&quot; if it is a regular expression value.<br>
/// It defaults to &quot;literal&quot;
Parameter REGEXMODE As String = "literal";

/// Set a valid regex pattern for value validation
Parameter REGEX As String;

/// Determines how the <method>Normalize</method> of the property
/// should clean up the value using the 
/// <a href="#DATACLEANUPSEQUENCE">DATACLEANUPSEQUENCE</a>
/// value.<br>
/// The <a href="#TRUNCATE">TRUNCATE</a> and 
/// <a href="#MAXLEN">MAXLEN</a> parameters are processed
/// last, and this setting does not affect the behaviour of TRUNCATE.<br>
/// The two options available are &quot;globalref&quot;
/// and &quot;literal&quot;, the first indicating that the 
/// <a href="#DATACLEANUPSEQUENCE">DATACLEANUPSEQUENCE</a> parameter contains
/// a reference to a global containing the sequence, and the second
/// indicating the it contains the actual sequence.<br>
/// It defaults to &quot;literal&quot;
Parameter DATACLEANUPMODE As String = "off";

/// A %List of cleanup instructions. If it is empty, 
/// then only the standard Normalization will be done.<br>
/// Each instruction is a %List with three values. These values
/// are used to perform $ZSTRIP calls. For a full reference of
/// options, see the documentation on $ZSTRIP<br>
/// <ul>
/// <li>1 - Mask</li>
/// <li>2 - Remove Characters</li>
/// <li>3 - Keep Characters</li>
/// </ul>
/// e.g. <pre>$lb("<>WC","","")</pre><br>
/// A sequence of cleanup instructions will be
/// <pre>$lb($lb("<>W","",""),$lb("*C","",""),$lb("*","-",""))</pre>
/// In this example, leading and trailing whitespace will be stippred first, 
/// then all control characters, and then any hyphens.
Parameter DATACLEANUPSEQUENCE As String;

/// Set whther the <a href="#ADDITIONALVALIDATIONCALL">ADDITIONALVALIDATIONCALL</a> parameter is a literal value
/// or if it references a global containing the call detail.<br>
/// Values are &quot;globalref&quot; when it refers to a global, and 
/// &quot;literal&quot; if it is the call command value.<br>
/// It defaults to &quot;literal&quot;
Parameter ADDITIONALVALIDATIONMODE As String = "literal";

/// In literal mode, thise is the classmethod that should
/// be invoked for additional validation after all the other 
/// validations have passed.<br>
/// The classmethod being called will receive the value as
/// input parameter. Ensure the type is the correct one for the
/// value being passed in.<br>
/// The classmethod should return a %Status.<br>
/// An example is: &quot;##class(baasvancodeza.Demo.IDNumberValidator).Validate()&quot;<br>
Parameter ADDITIONALVALIDATIONCALL As String;

/// Tests if the logical value <var>%val</var>, which is a string, is valid.
/// The validation is based on the class parameter settings used for the class attribute this data type is associated with.
/// In this case, <a href="#MINLEN">MINLEN</a>, <a href="#MAXLEN">MAXLEN</a>, and <a href="#REGEX">REGEX</a>.
ClassMethod IsValid(%val As %CacheString) As %Status [ CodeMode = objectgenerator, ServerOnly = 0 ]
{
	Do %code.WriteLine("	Quit:(%val="""") 1")
	Do %code.WriteLine("	Set tSC=1")
	Do %code.WriteLine("	Try {")

	// MAXLEN
	If ($GET(%parameter("MAXLEN")) '= "") {
		Do %code.WriteLine("		If ($LENGTH(%val) > " _ %parameter("MAXLEN") _ ") {")
		Do %code.WriteLine("			Return $$$ERROR($$$DTMaxLen, %val, " _ %parameter("MAXLEN") _ ")")
		Do %code.WriteLine("		}")
	}
	// MINLEN
	If ($GET(%parameter("MINLEN")) '= "") {
		Do %code.WriteLine("		If ($LENGTH(%val) < " _ %parameter("MINLEN") _ ") {")
		Do %code.WriteLine("			Return $$$ERROR($$$DTMinLen, %val, " _ %parameter("MINLEN") _ ")")
		Do %code.WriteLine("		}")
	}

	// REGEX Checks
	If ($GET(%parameter("REGEX")) '= "") {
		
		If (%parameter("REGEXMODE") = "globalref") {
			Do %code.WriteLine("		Set tRegex = $GET(" _ %parameter("REGEX") _ ")")
		} Else {
			Do %code.WriteLine("		Set tRegex = " _ ##class(%Global).Quote(%parameter("REGEX")))
		}
		Do %code.WriteLine("		If (tRegex '= """") {")
		Do %code.WriteLine("			Try {")
		Do %code.WriteLine("				If '$MATCH(%val, tRegex) {")
		Do %code.WriteLine("					Return $$$ERROR($$$DTPattern, %val, tRegex)")
		Do %code.WriteLine("				}")
		Do %code.WriteLine("			} Catch RegexEx {")
		Do %code.WriteLine("				Return $$$ERROR($$$URegexRuleSyntax)")
		Do %code.WriteLine("			}")
		Do %code.WriteLine("		}")
	}

	If ($GET(%parameter("ADDITIONALVALIDATIONCALL")) '= "") {
		If (%parameter("ADDITIONALVALIDATIONMODE") = "globalref") {
			Do %code.WriteLine("		Set tValidationCall = $GET(" _ %parameter("ADDITIONALVALIDATIONCALL") _ ")")
		} Else {
			Do %code.WriteLine("		Set tValidationCall = " _ ##class(%Global).Quote(%parameter("ADDITIONALVALIDATIONCALL")))
		}
		Do %code.WriteLine("		If (tValidationCall '= """") {")
		Do %code.WriteLine("			Try {")
		Do %code.WriteLine("				Set tCMeth = $PIECE($PIECE(tValidationCall,"")."",*),""("",1)")
		Do %code.WriteLine("				Set tClass = $PIECE($PIECE(tValidationCall,"")."",1),""##class("",*)")
		Do %code.WriteLine("				Set tSC = $CLASSMETHOD(tClass,tCMeth,%val)")
		Do %code.WriteLine("				Return:($$$ISERR(tSC)) tSC")
		Do %code.WriteLine("			} Catch CallEx {")
		Do %code.WriteLine("				Return CallEx.AsStatus()")
		Do %code.WriteLine("			}")
		Do %code.WriteLine("		}")
	}

	Do %code.WriteLine("	} Catch ex {")
	Do %code.WriteLine("		Set tSC = ex.AsStatus()")
	Do %code.WriteLine("	}")
	Do %code.WriteLine("	Quit tSC")
	Return $$$OK
}

/// First applies the <a href="DATACLEANUPSEQUENCE">DATACLEANUPSEQUENCE</a>
/// Then truncates value <var>%val</var> to <a href="#MAXLEN">MAXLEN</a>, characters.<br>
ClassMethod Normalize(%val As %CacheString) As %String [ CodeMode = objectgenerator, ServerOnly = 1 ]
{
	Do %code.WriteLine("	Set tVal = %val")
	If (%parameter("DATACLEANUPSEQUENCE") '= "") {
		If (%parameter("DATACLEANUPMODE") = "globalref") {
			Do %code.WriteLine("	Set tSeq = $GET(" _ %parameter("DATACLEANUPSEQUENCE") _ ")")
		} Else {
			Do %code.WriteLine("	Set tSeq = " _ %parameter("DATACLEANUPSEQUENCE"))
		}
		Do %code.WriteLine("	If (tSeq '= """"){")
		Do %code.WriteLine("		If '$LISTVALID(tSeq) {")
		Do %code.WriteLine("			XECUTE (""(out) Set out = "" _ tSeq, .tSeq)")
		Do %code.WriteLine("			If '$LISTVALID(tSeq) {")
		Do %code.WriteLine("				Set tSeq = """"")
		Do %code.WriteLine("			}")
		Do %code.WriteLine("		}")
		Do %code.WriteLine("	}")
		Do %code.WriteLine("	If (tSeq '= """"){")
		Do %code.WriteLine("		For i=1:1:$LISTLENGTH(tSeq) {")
		Do %code.WriteLine("			Set tCleaner = $LISTGET(tSeq,i)")
		Do %code.WriteLine("			If $LISTGET(tCleaner,1)="""",$LISTGET(tCleaner,2)="""",$LISTGET(tCleaner,3)="""" { ")
		Do %code.WriteLine("				continue")
		Do %code.WriteLine("			}")
		Do %code.WriteLine("			Set tVal = $ZSTRIP(tVal,$LISTGET(tCleaner,1),$LISTGET(tCleaner,2),$LISTGET(tCleaner,3))")
		Do %code.WriteLine("		}")
		Do %code.WriteLine("	}")
	}

	// TRUNCATE
	If %parameter("TRUNCATE"),%parameter("MAXLEN")'="" {
		Do %code.WriteLine("	Set tVal = $Extract(tVal,1," _ (+%parameter("MAXLEN")) _ ")")
	}
	
	Do %code.WriteLine("	Quit tVal")
	Quit $$$OK
}

}
