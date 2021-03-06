$domainObj = [System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain()
$PDC = ($domainObj.PdcRoleOwner).Name
$SearchString = "LDAP://"
$SearchString += $PDC + "/"
$DistinguishedName = "DC=$($domainObj.Name.Replace('.', ',DC='))"
$SearchString += $DistinguishedName
$SearchString
$Searcher = New-Object System.DirectoryServices.DirectorySearcher([ADSI]$SearchString)
$objDomain = New-Object System.DirectoryServices.DirectoryEntry
$Searcher.SearchRoot = $objDomain
$Searcher.filter="(&(objectClass=Group)(member=*))"
$GroupsWithMembers = $Searcher.FindAll()

Foreach($GroupWithMember in $GroupsWithMembers)
{
	Write-Host " - " -NoNewLine
	$GroupWithMember.Properties.name
	$GroupMembers = $GroupWithMember.Properties.member
	Foreach($GroupMember in $GroupMembers)
	{
		Write-Host "   | "
		Write-Host "   +-- " -NoNewLine
		$GroupMember
	}
	Write-Host "`n"
}
