/// String Datatype wiht regular expression support.
Class baasvancodeza.StringRgx.DataType Extends %Library.String [ ClientDataType = VARCHAR, OdbcType = VARCHAR, SqlCategory = STRING ]
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

/// Set whther the <a href="#REGEX">REGEX</a> parameter is a literal value
/// or if it references a global containing the regular expression.<br>
/// Values are &quot;globalref&quot; when it refers to a global, and 
/// &quot;literal&quot; if it is a regular expression value.<br>
/// It defaults to &quot;literal&quot;
Parameter REGEXMODE As String = "literal";

/// Set a valid regex pattern for value validation
Parameter REGEX As String;

/// Determines whether the <method>Normalize</method> of the property
/// should clean up the value using the 
/// <a href="#CLEANUPSEQUENCE">CLEANUPSEQUENCE</a>
/// value.<br>
/// The <a href="#TRUNCATE">TRUNCATE</a> and 
/// <a href="#MAXLEN">MAXLEN</a> parameters are processed
/// first, and this setting does not affect that behaviour.<br>
/// The other two options available are &quot;globalref&quot;
/// and &quot;literal&quot;, the first indicating that the 
/// <a href="#CLEANUPSEQUENCE">CLEANUPSEQUENCE</a> parameter contains
/// a reference to a global containing the sequence, and the second
/// indicating the it contains the actual sequence.<br>
/// It defaults to &quot;off&quot;
Parameter DATACLEANUPMODE As String = "off";

/// A %List of cleanup instructions.<br>
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
Parameter CLEANUPSEQUENCe As String;

/// Tests if the logical value <var>%val</var>, which is a string, is valid.
/// The validation is based on the class parameter settings used for the class attribute this data type is associated with.
/// In this case, <a href="#MINLEN">MINLEN</a>, <a href="#MAXLEN">MAXLEN</a>, and <a href="#REGEX">REGEX</a>.
ClassMethod IsValid(%val As %CacheString) As %Status [ CodeMode = objectgenerator, ServerOnly = 1 ]
{
    // TODO
    /*
	// Length checks
	if (..#MAXLEN '= "") {
		if ($length(%val) > ..#MAXLEN) {
			return $$$ERROR($$$DTMaxLen, %val, ..#MAXLEN)
		}
	}
	if (..#MINLEN '= "") {
		if ($length(%val) < ..#MINLEN) {
			return $$$ERROR($$$DTMinLen, %val, ..#MINLEN)
		}
	}
	// Regex check
	if (..#REGEX '= "") {
		try {
			if '$MATCH(%val, ..#REGEX) {
				return $$$ERROR($$$DTPattern, %val, ..#REGEX)
			}
		} catch Ex {
			return $$$ERROR($$$URegexRuleSyntax)
		}
	}
    */
	return $$$OK
}

}
