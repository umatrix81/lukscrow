Function Get-RP1($comp){
  write-host "Search",$comp
  try{
    $Computer = Get-ADComputer -identity $comp -Server domain.local
  }
  catch{
    return "Search error`n"
  }
  $obj = Get-ADObject -SearchBase $Computer.distinguishedname -Filter {objectclass -eq 'msFVE-RecoveryInformation'} -Properties *
 
  write-host "Found", ($obj | measure).Count, "password(s)"
  write-host ""
  foreach ($i in $obj){
    write-host "msFVE-RecoveryGuid:`t",([guid]($i.'msFVE-RecoveryGuid'))
    write-host "msFVE-VolumeGuid:`t",([guid]($i.'msFVE-VolumeGuid'))
    write-host "msFVE-RecoveryPassword:`t" $i.'msFVE-RecoveryPassword'
    write-host ""
  }
  
}
 
 
Get-RP1 ('ubuntu20')
 