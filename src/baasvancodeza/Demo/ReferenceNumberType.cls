/// Demonstrates the Normalize using the DATACLEANUPSEQUENCE in literal model.
Class baasvancodeza.Demo.ReferenceNumberType Extends baasvancodeza.DataTypes.SmartString [ CompileAfter = baasvancodeza.DataTypes.SmartString ]
{

Parameter MAXLEN = 40;

Parameter TRUNCATE = 1;

Parameter DATACLEANUPSEQUENCE = "$lb($lb(""*PC"","""","" ""),$lb(""<=>W"","""",""""))";

}
