
$SQLModuleCheck = Get-Module -ListAvailable SqlServer
if ($SQLModuleCheck -eq $null)
{
write-host "SqlServer Module Not Found - Installing"
# Not installed, trusting PS Gallery to remove prompt on install
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
# Installing module, requires run as admin for -scope AllUsers, change to CurrentUser if not possible
Install-Module -Name SqlServer –Scope AllUsers -Confirm:$false -AllowClobber
}
$checkClient = Get-ChildItem 'HKLM:\Software\Microsoft\*' -ea SilentlyContinue | Where {$_.name -like '*Client*'}

set-executionpolicy remotesigned 


$connconnSource = New-Object -Type System.Data.SqlClient.SqlConnection
$connconnSource.ConnectionString = 'Server=\\137.116.146.153:1344; Database=Customers;User=sa; Password=123456;Integrated Security = False;'
$connconnSource.Open();

#create your query to select from the source
$sorquery = " CREATE TABLE TEST2(ID INT PRIMARY KEY); ";
 
 #Create the source command which hold the driver and the query
$sorcommand = New-Object -Type System.Data.SqlClient.SqlCommand($sorquery, $connconnSource)

$sorcommand.ExecuteNonQuery();
 
#Close source connection
$connconnSource.Close();





 