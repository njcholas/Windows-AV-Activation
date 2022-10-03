try {$SO = systeminfo | findstr /B "OS Name" | Select-String "Windows"
$result = ($SO.Line.Split(':')[1] -replace " ", "")
} catch {}

$w16 = "MicrosoftWindowsServer2016Datacenter"
$w12 = "MicrosoftWindowsServer2012R2Datacenter"
$SO
$result

if ($result -eq $w12){
    echo "2012"
    $msseces = Get-Process msseces -ErrorAction SilentlyContinue
    If ([string]::IsNullOrEmpty($msseces)){
        cd C:\'Program Files'\'Microsoft Security Client'
        echo "Iniciando interface grafica"
        .\msseces.exe
        Start-Sleep -Seconds 5
        echo "Iniciando atualizacao de assinatura"
        .\MpCmdRun.exe -SignatureUpdate
        echo "Iniciando scan"
        .\MpCmdRun.exe -Scan -ScanType 2      
    } 
}

elseif ($result -eq $w16){
    echo "2016"
    $windefend = Get-Process WinDefend -ErrorAction SilentlyContinue
    If ([string]::IsNullOrEmpty($windefend)){
        cd C:\'Program Files'\'Windows Defender'
        .\MSASCui.exe
        Start-Sleep -Seconds 5
        .\MpCmdRun.exe -Scan -ScanType 2
        .\MpCmdRun.exe -SignatureUpdate
    } 
}