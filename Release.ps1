Add-Type -assembly "system.io.compression.filesystem"
$source = "Release"
$destination = "ZKEACMS.Core.v2.6.2.zip"
if(Test-Path $source){
    Remove-Item -Path $source -Force -Recurse
}
if(Test-path $destination) {    
    Remove-item -Path $destination -Force -Recurse
}

Write-Host "Starting release" $destination
Write-Host "This may take a few minutes, please wait..."
Set-Location src/ZKEACMS.WebHost
Invoke-Expression("dotnet publish-zkeacms")
Set-Location ../../
Write-Host "Copy files..."
Copy-Item -Path "src/ZKEACMS.WebHost/bin/Release/PublishOutput" -Destination "Release/Application" -Force -Recurse
Copy-Item -Path "DataBase" -Destination "Release/DataBase" -Force -Recurse
Write-Host "Archive to" $destination
[io.compression.zipfile]::CreateFromDirectory($Source, $destination) 
if(Test-Path $source){
    Write-Host "Cleaning..."
    Remove-Item -Path $source -Force -Recurse
}