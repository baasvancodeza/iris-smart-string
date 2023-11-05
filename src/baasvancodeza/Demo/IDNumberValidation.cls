/// Contains code to check the ID Number Check Digit
Class baasvancodeza.Demo.IDNumberValidation
{

ClassMethod Validate(pVal As %CacheString) As %Status
{
    Set tSC = $$$OK
    Try {
        Set tOdd = 0
        Set tEven = 0
        ; Odd Positions
        For i=1:2:11 {
            Set tOdd = tOdd + $EXTRACT(pVal,i)
        }
        ; Even Positions
        For i=2:2:12 {
            Set tEven = tEven + $EXTRACT(pVal,i)
        }
        Set tDiff = "" _ $ZABS(tOdd - tEven)
        Set tCheckVal = $EXTRACT(tDiff,$LENGTH(tDiff))

        If tCheckVal'=$EXTRACT(pVal,$LENGTH(pVal)) {
            Set tSC = $$$ERROR($$$GeneralError,$$$FormatText("'%1' is not a valid ID Number.",pVal))
        }
    } Catch ex {
        Set tSC = ex.AsStatus()
    }
    Quit tSC
}

}
