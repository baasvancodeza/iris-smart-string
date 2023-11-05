/// Demonstrate Validation with REGEX as literal
Class baasvancodeza.Demo.PhoneNumberType Extends baasvancodeza.DataTypes.SmartString [ CompileAfter = baasvancodeza.DataTypes.SmartString ]
{

Parameter MINLEN = 7;

Parameter MAXLEN = 15;

Parameter REGEX = "^\""\+\d{1,3}\""\d{1,15}$";

}
