@echo off
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "$u='https://raw.githubusercontent.com/PhenomenalAjay/RamDetails/main/RamDetails.ps1';" ^
  "$c='https://raw.githubusercontent.com/PhenomenalAjay/RamDetails/main/RamDetails.ps1.sha256';" ^
  "$o=\"$env:TEMP\\RamDetails.ps1\";$oc=\"$env:TEMP\\RamDetails.ps1.sha256\";" ^
  "Invoke-WebRequest -Uri $c -OutFile $oc -UseBasicParsing;" ^
  "Invoke-WebRequest -Uri $u -OutFile $o -UseBasicParsing;" ^
  "$expected=(Get-Content $oc -Raw).Trim();$actual=(Get-FileHash -Path $o -Algorithm SHA256).Hash;" ^
  "if($expected -ne $actual){Write-Error 'Checksum mismatch — aborting.'; Remove-Item $o,$oc -Force -ErrorAction SilentlyContinue; exit 1};" ^
  "Write-Host 'Checksum OK. Showing first 12 lines...'; Get-Content $o -TotalCount 12;" ^
  "if((-not (Read-Host 'Run script? (y/N)') -match '^[Yy]$')){Write-Host 'Aborted by user'; exit 0}; & $o"
