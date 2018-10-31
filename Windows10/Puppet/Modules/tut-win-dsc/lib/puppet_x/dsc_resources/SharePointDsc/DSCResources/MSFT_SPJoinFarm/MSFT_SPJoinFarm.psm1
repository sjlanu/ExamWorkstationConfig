function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [parameter(Mandatory = $true)]  
        [System.String] 
        $FarmConfigDatabaseName,

        [parameter(Mandatory = $true)]  
        [System.String] 
        $DatabaseServer,

        [parameter(Mandatory = $true)]  
        [System.Management.Automation.PSCredential] 
        $Passphrase,

        [parameter(Mandatory = $false)] 
        [System.Management.Automation.PSCredential] 
        $InstallAccount,

        [parameter(Mandatory = $false)] 
        [System.String] 
        [ValidateSet("Application",
                     "ApplicationWithSearch",
                     "Custom",
                     "DistributedCache",
                     "Search",
                     "SingleServer",
                     "SingleServerFarm",
                     "WebFrontEnd",
                     "WebFrontEndWithDistributedCache")] 
        $ServerRole
    )

    Write-Verbose -Message ("WARNING! SPCreateFarm is deprecated and will be removed in " + `
                            "SharePointDsc v2.0. Swap to use the new SPFarm resource as " + `
                            "an alternative. See http://aka.ms/SPDsc-SPFarm for details.")

    Write-Verbose -Message "Getting local farm presence"

    if (($PSBoundParameters.ContainsKey("ServerRole") -eq $true) `
        -and (Get-SPDSCInstalledProductVersion).FileMajorPart -ne 16) 
    {
        throw [Exception] "Server role is only supported in SharePoint 2016."
    }

    if (($PSBoundParameters.ContainsKey("ServerRole") -eq $true) `
        -and (Get-SPDSCInstalledProductVersion).FileMajorPart -eq 16 `
        -and (Get-SPDSCInstalledProductVersion).FileBuildPart -lt 4456 `
        -and ($ServerRole -eq "ApplicationWithSearch" `
             -or $ServerRole -eq "WebFrontEndWithDistributedCache")) 
    {
        throw [Exception] ("ServerRole values of 'ApplicationWithSearch' or " + `
                           "'WebFrontEndWithDistributedCache' require the SharePoint 2016 " + `
                           "Feature Pack 1 to be installed. See " + `
                           "https://support.microsoft.com/en-au/kb/3127940")
    }

    $result = Invoke-SPDSCCommand -Credential $InstallAccount `
                                  -Arguments $PSBoundParameters `
                                  -ScriptBlock {
        $params = $args[0]
        
        $getSPMajorVersion = (Get-SPDSCInstalledProductVersion).FileMajorPart
        $cfgDbRegKey = "hklm:SOFTWARE\Microsoft\Shared Tools\Web Server Extensions\$getSPMajorVersion.0\Secure\ConfigDB"
        try
        {
            $configDbDsn = Get-SPDSCRegistryKey -Key $cfgDbRegKey -Value "dsn"
        }
        catch
        {
            Write-Verbose -Message "SharePoint registry key cannot be found."
        }
        $serverIsJoined = $true

        if ($null -eq $configDbDsn)
        {
            $serverIsJoined = $false
        }
        elseif (-NOT($configDbDsn.Contains($params.FarmConfigDatabaseName)))
        {
            $serverIsJoined = $false
        } 

        try 
        {
            $spFarm = Get-SPFarm
        } 
        catch 
        {
            Write-Verbose -Message "Unable to detect local farm."
            if ($serverIsJoined)
            {
                throw 'Server already joined to farm but SPFarm not reachable'
            }
        }
        
        if ($null -eq $spFarm) 
        {
            return @{
                FarmConfigDatabaseName = ""
                DatabaseServer = ""
                InstallAccount = ""
                Passphrase = "" 
            }
        }

        $configDb = Get-SPDatabase | Where-Object -FilterScript { 
            $_.Name -eq $spFarm.Name -and $_.Type -eq "Configuration Database" 
        }

        return @{
            FarmConfigDatabaseName = $spFarm.Name
            DatabaseServer = $configDb.Server.Name
            InstallAccount = $params.InstallAccount
            Passphrase = $params.Passphrase.password 
        }
    }
    return $result
}

function Set-TargetResource
{
    # Supressing the global variable use to allow passing DSC the reboot message
    [CmdletBinding()]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidGlobalVars", "")]
    param
    (
        [parameter(Mandatory = $true)]  
        [System.String] 
        $FarmConfigDatabaseName,

        [parameter(Mandatory = $true)]  
        [System.String] 
        $DatabaseServer,

        [parameter(Mandatory = $true)]  
        [System.Management.Automation.PSCredential] 
        $Passphrase,

        [parameter(Mandatory = $false)] 
        [System.Management.Automation.PSCredential] 
        $InstallAccount,

        [parameter(Mandatory = $false)] 
        [System.String] 
        [ValidateSet("Application",
                     "ApplicationWithSearch",
                     "Custom",
                     "DistributedCache",
                     "Search",
                     "SingleServer",
                     "SingleServerFarm",
                     "WebFrontEnd",
                     "WebFrontEndWithDistributedCache")] 
        $ServerRole
    )

    Write-Verbose -Message ("WARNING! SPCreateFarm is deprecated and will be removed in " + `
                            "SharePointDsc v2.0. Swap to use the new SPFarm resource as " + `
                            "an alternative. See http://aka.ms/SPDsc-SPFarm for details.")

    Write-Verbose -Message "Setting local farm"

    if (($PSBoundParameters.ContainsKey("ServerRole") -eq $true) `
        -and (Get-SPDSCInstalledProductVersion).FileMajorPart -ne 16) 
    {
        throw [Exception] "Server role is only supported in SharePoint 2016."
    }

    if (($PSBoundParameters.ContainsKey("ServerRole") -eq $true) `
        -and (Get-SPDSCInstalledProductVersion).FileMajorPart -eq 16 `
        -and (Get-SPDSCInstalledProductVersion).FileBuildPart -lt 4456 `
        -and ($ServerRole -eq "ApplicationWithSearch" `
             -or $ServerRole -eq "WebFrontEndWithDistributedCache")) 
    {
        throw [Exception] ("ServerRole values of 'ApplicationWithSearch' or " + `
                           "'WebFrontEndWithDistributedCache' require the SharePoint 2016 " + `
                           "Feature Pack 1 to be installed. See " + `
                           "https://support.microsoft.com/en-au/kb/3127940")
    }

    $CurrentValues = Get-TargetResource @PSBoundParameters
    if ([string]::IsNullOrEmpty($CurrentValues.FarmConfigDatabaseName) -eq $false) 
    {
        throw ("This server is already connected to a farm " + `
               "($($CurrentValues.FarmConfigDatabaseName)). Please manually remove it " + `
               "to apply this change.")
    }

    $result = Invoke-SPDSCCommand -Credential $InstallAccount `
                                  -Arguments @($PSBoundParameters, $PSScriptRoot) `
                                  -ScriptBlock {
                                      
        $params = $args[0]
        $scriptRoot = $args[1]

        $modulePath = "..\..\Modules\SharePointDsc.Farm\SPFarm.psm1"
        Import-Module -Name (Join-Path -Path $scriptRoot -ChildPath $modulePath -Resolve)
        $dbStatus = Get-SPDSCConfigDBStatus -SQLServer $params.DatabaseServer `
                                            -Database $params.FarmConfigDatabaseName

        while ($dbStatus.Locked -eq $true)
        {
            Write-Verbose -Message ("[$([DateTime]::Now.ToShortTimeString())] The configuration " + `
                                    "database is currently being provisioned by a remote " + `
                                    "server, this server will wait for this to complete")
            Start-Sleep -Seconds 30
            $dbStatus = Get-SPDSCConfigDBStatus -SQLServer $params.DatabaseServer `
                                                -Database $params.FarmConfigDatabaseName
        }

        if ($dbStatus.ValidPermissions -eq $false)
        {
            throw "The current user does not have sufficient permissions to SQL Server"
            return
        }
        
        try {
            $joinFarmArgs = @{
                DatabaseServer = $params.DatabaseServer
                DatabaseName = $params.FarmConfigDatabaseName
                Passphrase = $params.Passphrase.password
                SkipRegisterAsDistributedCacheHost = $true
            }
            
            switch((Get-SPDSCInstalledProductVersion).FileMajorPart) {
                15 {
                    Write-Verbose -Message "Detected Version: SharePoint 2013"
                }
                16 {
                    if ($params.ContainsKey("ServerRole") -eq $true) {
                        Write-Verbose -Message ("Detected Version: SharePoint 2016 - " + `
                                                "configuring server as $($params.ServerRole)")
                        $joinFarmArgs.Add("LocalServerRole", $params.ServerRole)
                    } else {
                        Write-Verbose -Message ("Detected Version: SharePoint 2016 - no server " + `
                                                "role provided, configuring server without a " + `
                                                "specific role")
                    }
                }
                Default {
                    throw [Exception] ("An unknown version of SharePoint (Major version $_) " + `
                                       "was detected. Only versions 15 (SharePoint 2013) or " + `
                                       "16 (SharePoint 2016) are supported.")
                }
            }

            Connect-SPConfigurationDatabase @joinFarmArgs
            Install-SPHelpCollection -All
            Initialize-SPResourceSecurity
            Install-SPService
            Install-SPFeature -AllExistingFeatures -Force  | out-null 
            Install-SPApplicationContent    
        }
        catch [System.Exception] {
            return $_
        }
    }

    if ($null -ne $result)
    {
        Write-Verbose -Message "An error occured joining the farm"
        throw $_
    }

    Write-Verbose -Message "Starting timer service"
    Start-Service -Name sptimerv4

    Write-Verbose -Message ("Pausing for 5 minutes to allow the timer service to " + `
                            "fully provision the server")
    Start-Sleep -Seconds 300
    Write-Verbose -Message ("Join farm complete. Restarting computer to allow " + `
                            "configuration to continue")

    $global:DSCMachineStatus = 1
}

function Test-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param
    (
        [parameter(Mandatory = $true)]  
        [System.String] 
        $FarmConfigDatabaseName,

        [parameter(Mandatory = $true)]  
        [System.String] 
        $DatabaseServer,

        [parameter(Mandatory = $true)]  
        [System.Management.Automation.PSCredential] 
        $Passphrase,

        [parameter(Mandatory = $false)] 
        [System.Management.Automation.PSCredential] 
        $InstallAccount,

        [parameter(Mandatory = $false)] 
        [System.String] 
        [ValidateSet("Application",
                     "ApplicationWithSearch",
                     "Custom",
                     "DistributedCache",
                     "Search",
                     "SingleServer",
                     "SingleServerFarm",
                     "WebFrontEnd",
                     "WebFrontEndWithDistributedCache")] 
        $ServerRole
    )

    Write-Verbose -Message "Testing for local farm presence"

    if (($PSBoundParameters.ContainsKey("ServerRole") -eq $true) `
        -and (Get-SPDSCInstalledProductVersion).FileMajorPart -ne 16) 
    {
        throw [Exception] "Server role is only supported in SharePoint 2016."
    }

    $CurrentValues = Get-TargetResource @PSBoundParameters

    return Test-SPDscParameterState -CurrentValues $CurrentValues `
                                    -DesiredValues $PSBoundParameters `
                                    -ValuesToCheck @("FarmConfigDatabaseName") 
}

Export-ModuleMember -Function *-TargetResource
