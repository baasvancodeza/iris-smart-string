Class baasvancodeza.Demo.RunDemo
{

ClassMethod Run()
{
	Write !,"Creating object with invalid values and dirty data"
	Set obj = ##class(baasvancodeza.Demo.Person).%New()
	Set obj.LastName = "o'Connor  /de-Silva +"
	Set obj.FirstName = "Mark01/"
	Set obj.IDNumber = "12332178909000"
	Set obj.PhoneNumber = "+23-234234234"

	Write !,"Set obj = ##class(baasvancodeza.Demo.Person).%New()"
	Write !,"Set obj.LastName = ""o'Connor  /de-Silva +"""
	Write !,"Set obj.FirstName = ""Mark01/"""
	Write !,"Set obj.IDNumber = ""12332178909000"""
	Write !,"Set obj.PhoneNumber = ""+23-234234234"""

	Write !!,"Validating"
	Set sc = obj.%ValidateObject()
	Write !,$SYSTEM.Status.GetErrorText(sc)
	Write !!,"Review the comamnds that were executed and the results"
	Read !,"Pres Enter to continue",x

	Write !!,"=========================="
	Write !,"Normalizing Object"
	Do obj.%NormalizeObject()
	Write !,"obj.LastName: ",obj.LastName
	Write !,"obj.FirstName: ",obj.FirstName
	
	Write !!,"Validating again"
	Set sc = obj.%ValidateObject()
	Write !,$SYSTEM.Status.GetErrorText(sc)
	Write !!,"Review the validation results after the data cleanup."
	Read !,"Pres Enter to continue",x

	Write !!,"=========================="
	Write !,"Setting values of fields that are not set up to cleanup with the normalize."
	Write !," - Correct Phone Number"
	Write !," - ID Number length fixed."

	Write !,"Set obj.IDNumber = ""8313405566110"""
	Write !,"Set obj.PhoneNumber = ""+23""234234234"
	Set obj.IDNumber = "8313405566110"
	Set obj.PhoneNumber = """+23""234234234"

	Write !,"Validating again"
	Set sc = obj.%ValidateObject()
	Write !,$SYSTEM.Status.GetErrorText(sc)
	Write !!,"Review the validation results after value changes."
	Read !,"Pres Enter to continue",x


	Write !!,"=========================="
	Write !,"Setting values of ID Number to a valid value."
	Write !,"Set obj.IDNumber = ""8313405566117"""
	Set obj.IDNumber = "8313405566117"

	Write !,"Validating again"
	Set sc = obj.%ValidateObject()
	Write !,"Status: ",sc
	Read !,"Pres Enter to continue",x
	Write obj.%Save()
	Write !,"Object Saved"
}

}
