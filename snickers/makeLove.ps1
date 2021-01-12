$ZipName = "$($PSScriptRoot)\snickers.zip"

Compress-Archive -LiteralPath $PSScriptRoot\main.lua, 
$PSScriptRoot\oldHero.png, $PSScriptRoot\airport.png, 
$PSScriptRoot\speech.png, $PSScriptRoot\win.png, 
$PSScriptRoot\press.png -DestinationPath $ZipName -Update

$FileName = "$($PSScriptRoot)\snickers.love"
if (Test-Path $FileName) 
{
  Remove-Item $FileName
}

Rename-Item -Path $ZipName -NewName $FileName

.\snickers.love