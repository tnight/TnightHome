<# Set laptop screen brightness automatically
-  50% when on Battery
- 100% when on AC
#>

### while ($true){

    $PLUGGEDIN = (Get-WmiObject -Class BatteryStatus -Namespace root\wmi -ComputerName "localhost").PowerOnLine

    if ($PLUGGEDIN){

        (Get-WmiObject -Namespace root/WMI -Class WmiMonitorBrightnessMethods).WmiSetBrightness(1,100)

    }else{

        (Get-WmiObject -Namespace root/WMI -Class WmiMonitorBrightnessMethods).WmiSetBrightness(1,50)

    }

    sleep 5

### }