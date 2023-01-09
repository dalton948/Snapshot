<# Script made by 
 .----------------.  .----------------.  .----------------.  .----------------.  .----------------.  .-----------------.
| .--------------. || .--------------. || .--------------. || .--------------. || .--------------. || .--------------. |
| |  ________    | || |      __      | || |   _____      | || |  _________   | || |     ____     | || | ____  _____  | |
| | |_   ___ `.  | || |     /  \     | || |  |_   _|     | || | |  _   _  |  | || |   .'    `.   | || ||_   \|_   _| | |
| |   | |   `. \ | || |    / /\ \    | || |    | |       | || | |_/ | | \_|  | || |  /  .--.  \  | || |  |   \ | |   | |
| |   | |    | | | || |   / ____ \   | || |    | |   _   | || |     | |      | || |  | |    | |  | || |  | |\ \| |   | |
| |  _| |___.' / | || | _/ /    \ \_ | || |   _| |__/ |  | || |    _| |_     | || |  \  `--'  /  | || | _| |_\   |_  | |
| | |________.'  | || ||____|  |____|| || |  |________|  | || |   |_____|    | || |   `.____.'   | || ||_____|\____| | |
| |              | || |              | || |              | || |              | || |              | || |              | |
| '--------------' || '--------------' || '--------------' || '--------------' || '--------------' || '--------------' |
 '----------------'  '----------------'  '----------------'  '----------------'  '----------------'  '----------------' 
 let me know if you have any questions
 #>


Write-host "
   _________                        _________.__            __   
 /   _____/ ____ _____  ______    /   _____/|  |__   _____/  |_ 
 \_____  \ /    \\__  \ \____ \   \_____  \ |  |  \ /  _ \   __\
 /        \   |  \/ __ \|  |_> >  /        \|   Y  (  <_> )  |  
/_______  /___|  (____  /   __/  /_______  /|___|  /\____/|__|  
        \/     \/     \/|__|             \/      \/             
 "

Write-Host ""
Write-Host "Snap Shot - Please choose an option:"
Write-Host ""
Write-Host "1: Snap Shot one server"
Write-Host "2: Snap Shot a list of servers"
Write-Host "Q: To quit out"
$selection = Read-Host "Please enter which option you need".trim()

#Pulls up explorer to select your file
Function get-FileName($initialDirectory) {
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
    
    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog.initialDirectory = $initialDirectory
    $OpenFileDialog.ShowDialog() | Out-Null
    $OpenFileDialog.filename
}
###################


<#
get-vm louappwts1492 | get-snapshot | remove-snapshot -runasync -confirm:$false
get-vm louappwts1492 | New-Snapshot -Name "SCTASK0636822" -Description "SCTASK0636822" -Confirm
#>
if ($selection -eq 1) {
    $server = Read-host "Please enter your server name".trim()
    $task = Read-host "Please enter your Task #".trim()
    stop-vm $server
    write-host "Removing old Snapshots"
    get-vm $server | get-snapshot | remove-snapshot -runasync -confirm:$false | Out-Null
    write-host "Taking new Snapshots"
    get-vm $server | New-Snapshot -Name $task -Description $task -Confirm:$false
    Write-host "Printing Validation"
    get-snapshot $server | Select-Object name, vm, created | Format-Table
    start-vm $server
}
elseIf ($selection -eq 2) {
    $path = Get-FileName
    $thelist = Get-Content -path $path
    $task = Read-host "Please enter your Task #".trim()
    stop-vm $thelist
    write-host "Removing old Snapshots"
    get-vm $thelist | get-snapshot | remove-snapshot -runasync -confirm:$false | Out-Null
    write-host "Taking new Snapshots"
    get-vm $thelist | New-Snapshot -Name $task -Description $task -Confirm:$false
    Write-host "Printing Validation"
    get-snapshot $thelist | Select-Object name, vm, created | Format-Table
    Start-vm $thelist
}
elseif ($select.ToUpper -eq "Q") {
    exit
}