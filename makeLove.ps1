$ZipName = "$($PSScriptRoot)\gameTest.zip"

Compress-Archive -LiteralPath $PSScriptRoot\main.lua, $PSScriptRoot\tween.lua -DestinationPath $ZipName -Update

$FileName = "$($PSScriptRoot)\gameTest.love"
if (Test-Path $FileName) 
{
  Remove-Item $FileName
}

Rename-Item -Path $ZipName -NewName $FileName

.\gameTest.love