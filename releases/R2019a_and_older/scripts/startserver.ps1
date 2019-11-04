<#
.SYNOPSIS
startserver:              Start the Network License Manager dashboard

# Copyright 2018 The MathWorks, Inc.

.DESCRIPTION
Usage:                    startserver

.EXAMPLE
startserver
#>

# Set default behaviour to stop on error
$ErrorActionPreference = "Stop"

# Open required firewall ports
Get-NetFirewallRule | ?{$_.Name -like "RemoteSvcAdmin*"} | Enable-NetFirewallRule
New-NetFirewallRule -Name "https_inbound" -DisplayName "https_inbound" -Direction Inbound -Action Allow -Protocol TCP -LocalPort 443 -ErrorAction SilentlyContinue
New-NetFirewallRule -Name "flex_inbound" -DisplayName "flex_inbound" -Direction Inbound -Action Allow -Protocol TCP -LocalPort 27000-27001 -ErrorAction SilentlyContinue

# restart the main process
net stop networklicensemanagerconsole.exe
net start networklicensemanagerconsole.exe

Exit
