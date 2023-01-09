Snapshot powershell Script

based off of these two commands.

get-vm louappwts1492 | get-snapshot | remove-snapshot -runasync -confirm:$false
get-vm louappwts1492 | New-Snapshot -Name "SCTASK0636822" -Description "SCTASK0636822" -Confirm


Option 1 lets you enter a single server and also your task #.
Option 2 prompts the user to select a list from their machine.