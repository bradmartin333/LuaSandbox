Compress-Archive -LiteralPath C:\Users\dingo\Desktop\game\main.lua, C:\Users\dingo\Desktop\game\tween.lua -DestinationPath C:\Users\dingo\Desktop\game\gameTest.zip -Update

$FileName = "C:\Users\dingo\Desktop\game\gameTest.love"
if (Test-Path $FileName) 
{
  Remove-Item $FileName
}

Rename-Item -Path C:\Users\dingo\Desktop\game\gameTest.zip -NewName C:\Users\dingo\Desktop\game\gameTest.love

.\gameTest.love