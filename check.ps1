$targetIP = "10.10.48.254"
$webhookURL = "https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

function Send-WeChatMessage {
    param (
        [string]$message
    )
    $currentTime = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $fullMessage = "$currentTime - $message"

    $jsonBody = @{
        "msgtype" = "text"
        "text" = @{
            "content" = $fullmessage
        }
    } | ConvertTo-Json

    Invoke-RestMethod -Uri $webhookURL -Method Post -Body $jsonBody -ContentType 'application/json'
}

while ($true) {
    $pingResult = Test-Connection -ComputerName $targetIP -Count 1 -ErrorAction SilentlyContinue

    if ($pingResult -eq $null) {
        $errorMessage = "Unable to access $targetIP from 10.120.20.122, Please check the network"
        Write-Host $errorMessage
        Send-WeChatMessage -message $errorMessage
#        break
    }
    else {
        Write-Host "Network from A to B is ok."
#        $fineMessage = "Seccessful access to $targetIP from 10.120.20.122, Network from A to G is ok"
#        Write-Host $fineMessage
#        Send-WeChatMessage -message $fineMessage
#        break
    }

    Start-Sleep -Seconds 60
#	$host.SetShouldExit()
}
