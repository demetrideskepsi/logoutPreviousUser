<# gets the user who's logged in will show extra strings like below
username
DOMAINNAME\theusername
we need to remove the domain name and \ so that's what the line after does
#>
$username = Get-WMIObject -class Win32_ComputerSystem | select username | findstr /r '.*\\'

# regex to remove the domain name and \
$username = $username -replace '.*\\'

# gets the ID of the user who logged in before so we can log them out

$session = ((quser | ? { $_ -notmatch $username -and $_ -notmatch 'SESSIONNAME' }) -split '([0-9]  +Disc)')[1] -replace ' +Disc.*'
# logs that previous user out by ID
logoff $session