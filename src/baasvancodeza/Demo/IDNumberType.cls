/// An Identification Number field (SSN) that can be configured
/// per deployment.
Class baasvancodeza.Demo.IDNumberType Extends baasvancodeza.DataTypes.SmartString [ CompileAfter = baasvancodeza.DataTypes.SmartString ]
{

Parameter REGEXMODE = "globalref";

Parameter REGEX = "^SysConfig(""IDNumberRegex"")";

Parameter ADDITIONALVALIDATIONCALL = "##class(baasvancodeza.Demo.IDNumberValidation).Validate()";

}
