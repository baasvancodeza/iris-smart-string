/// A datatype with Normalization configurable per deployment, 
/// changeable at any time without having to recompile
Class baasvancodeza.Demo.LastNameType Extends baasvancodeza.DataTypes.SmartString [ CompileAfter = baasvancodeza.DataTypes.SmartString ]
{

Parameter MAXLEN = 60;

Parameter TRUNCATE = 1;

Parameter DATACLEANUPMODE = "globalref";

Parameter DATACLEANUPSEQUENCE = "^SysConfig(""LastNameCleanup"")";

}
