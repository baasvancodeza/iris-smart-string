/// A persistent class to showcase the Normalization and Validation
Class baasvancodeza.Demo.Person Extends %Persistent
{

Property IDNumber As IDNumberType [ Required ];

Property FirstName As baasvancodeza.DataTypes.SmartString(DATACLEANUPSEQUENCE = "$lb($lb(""*CPN"","""","" ""),$lb(""<=>W"","""",""""))", REGEX = "^[a-zA-Z ]*$");

Property LastName As LastNameType [ Required ];

Property PhoneNumber As PhoneNumberType;

Storage Default
{
<Data name="PersonDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>IDNumber</Value>
</Value>
<Value name="3">
<Value>FirstName</Value>
</Value>
<Value name="4">
<Value>LastName</Value>
</Value>
<Value name="5">
<Value>PhoneNumber</Value>
</Value>
</Data>
<DataLocation>^baasvancodeza.Demo.PersonD</DataLocation>
<DefaultData>PersonDefaultData</DefaultData>
<IdLocation>^baasvancodeza.Demo.PersonD</IdLocation>
<IndexLocation>^baasvancodeza.Demo.PersonI</IndexLocation>
<StreamLocation>^baasvancodeza.Demo.PersonS</StreamLocation>
<Type>%Library.CacheStorage</Type>
}

}
