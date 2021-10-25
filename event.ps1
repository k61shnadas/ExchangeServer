Get-WinEvent -LogName System -MaxEvents 500| where{$_.LevelDisplayName -eq "Error"}


Invoke-Command -ComputerName almanexch1 -ScriptBlock{Get-WinEvent -LogName Application -MaxEvents 100|where{$_.LevelDisplayName -eq "Error"}|Format-List}
