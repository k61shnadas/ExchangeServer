
#Here servername1 & servername2 are exchnager server name and this one for DAG server Upgrade

--------------------Keep in Maintenance Mode---------------------------
Set-ServerComponentState servername1 –Component HubTransport –State Draining –Requester Maintenance
Restart-Service MSExchangeTransport

CD $ExScripts
.\StartDagServerMaintenance.ps1 -ServerName servername1  -MoveComment Maintenance -PauseClusterNode

Redirect-Message -Server servername1 -Target servername2.almanaratain.com
Set-ServerComponentState servername1 –Component ServerWideOffline –State InActive –Requester Maintenance


-----------------------------------------------------Maintenance Mode Check---------------------------

Get-ServerComponentState servername1 | Format-Table Component,State -Autosize
Get-MailboxServer servername1 | Format-List DatabaseCopyAutoActivationPolicy
Get-ClusterNode servername1 | Format-List
Get-Queue

--------------------Out of Maintenance---------------------------------------------------

Set-ServerComponentState servername1 -Component ServerWideOffline -State Active -Requester Maintenance

CD $ExScripts
.\StopDagServerMaintenance.ps1 -serverName almanexch1

Set-ServerComponentState servername1 -Component HubTransport -State Active -Requester Maintenance

Restart-Service MSExchangeTransport
