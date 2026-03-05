# Dieses Skript setzt Sicherheitseinstellungen nach Bitdefender empfehlungen auf Host ohne Domainzugehoerigkeit
# Stannek GmbH - E.Sauerbier - v.1.2 - 05.03.2026

# Parameter

# Telefonie-Dienst deaktvieren
Get-Service -Name tapisrv | Set-Service -StartupType Disabled -Verbose | Stop-Service -Verbose

# Autologin deaktivieren
New-ItemProperty -Type String -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name "AutoAdminLogon" -value "0" -Force -Verbose

# Richtlinie setzen
New-Item "HKLM:\SOFTWARE\Policies\Microsoft\Windows\LanmanWorkstation" -Force
New-ItemProperty -Type DWord -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\LanmanWorkstation" -Name "AllowInsecureGuestAuth" -value "0" -Force -Verbose
New-Item "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Client" -Force
New-ItemProperty -Type DWord -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Client" -Name "AllowDigest" -value "0" -Force -Verbose
New-Item "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Service" -Force
New-ItemProperty -Type DWord -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Service" -Name "DisableRunAs" -value "1" -Force -Verbose
New-ItemProperty -Type DWord -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters" -Name "DisableIPSourceRouting" -value "2" -Force -Verbose
New-ItemProperty -Type DWord -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" -Name "EnableICMPRedirect" -value "0" -Force -Verbose
New-Item "HKLM:\SYSTEM\CurrentControlSet\Policies\EarlyLaunch" -Force
New-ItemProperty -Type DWord -Path "HKLM:\SYSTEM\CurrentControlSet\Policies\EarlyLaunch" -Name "DriverLoadPolicy" -value "3" -Force -Verbose
New-ItemProperty -Type DWord -Path "HKLM:\SYSTEM\CurrentControlSet\Control\LSA" -Name "disabledomaincreds" -value "1" -Force -Verbose
New-ItemProperty -Type DWord -Path "HKLM:\SYSTEM\CurrentControlSet\Control\LSA" -Name "restrictanonymous" -value "1" -Force -Verbose
New-ItemProperty -Type DWord -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -Name "RequireSecuritySignature" -value "1" -Force -Verbose
New-ItemProperty -Type DWord -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" -Name "RequireSecuritySignature" -value "1" -Force -Verbose

New-Item "HKLM:\SOFTWARE\Policies\Microsoft\Biometrics\FacialFeatures" -Force
New-ItemProperty -Type DWord -Path "HKLM:\SOFTWARE\Policies\Microsoft\Biometrics\FacialFeatures" -Name "EnhancedAntiSpoofing" -value "1" -Force -Verbose
New-ItemProperty -Type DWord -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "NoDriveTypeAutoRun" -value "255" -Force -Verbose
New-Item "HKLM:\SOFTWARE\Policies\Microsoft\WindowsInkWorkspace" -Force
New-ItemProperty -Type DWord -Path "HKLM:\SOFTWARE\Policies\Microsoft\WindowsInkWorkspace" -Name "AllowWindowsInkWorkspace" -value "1" -Force -Verbose
New-Item "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CredentialsDelegation" -Force
New-ItemProperty -Type DWord -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CredentialsDelegation" -Name "AllowProtectedCreds" -value "1" -Force -Verbose
New-Item "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AxInstaller" -Force
New-ItemProperty -Type DWord -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AxInstaller" -Name "OnlyUseAXISForActiveXInstall" -value "1" -Force -Verbose
New-Item "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging" -Force
New-ItemProperty -Type DWord -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging" -Name "EnableScriptBlockLogging" -value "1" -Force -Verbose




# Richtlinien fuer IE setzen
New-Item "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings" -Force
New-ItemProperty -Type DWord -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings" -Name "CallLegacyWCMPolicies" -value "0" -Force -Verbose
New-ItemProperty -Type DWord -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings" -Name "CertificateRevocation" -value "1" -Force -Verbose
New-ItemProperty -Type DWord -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings" -Name "ListBox_Support_ZoneMapKey" -value "1" -Force -Verbose
New-ItemProperty -Type DWord -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings" -Name "PreventIgnoreCertErrors" -value "1" -Force -Verbose
New-ItemProperty -Type DWord -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings" -Name "SecureProtocols" -value "2560" -Force -Verbose
New-ItemProperty -Type DWord -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings" -Name "Security_HKLM_only" -value "1" -Force -Verbose
New-ItemProperty -Type DWord -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings" -Name "Security_options_edit" -value "1" -Force -Verbose
New-ItemProperty -Type DWord -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings" -Name "Security_zones_map_edit" -value "1" -Force -Verbose
New-ItemProperty -Type DWord -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings" -Name "WarnOnBadCertRecving" -value "1" -Force -Verbose
New-Item "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Download" -Force
New-ItemProperty -Type String -Path "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Download" -Name "CheckExeSignatures" -value "yes" -Force -Verbose
New-ItemProperty -Type DWord -Path "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Download" -Name "RunInvalidSignatures" -value "0" -Force -Verbose
New-Item "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Feeds" -Force
New-ItemProperty -Type DWord -Path "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Feeds" -Name "DisableEnclosureDownload" -value "1" -Force -Verbose
New-Item "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_RESTRICT_ACTIVEXINSTALL" -Force
New-ItemProperty -Type String -Path "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_RESTRICT_ACTIVEXINSTALL" -Name "explorer.exe" -value "1" -Force -Verbose
New-ItemProperty -Type String -Path "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_RESTRICT_ACTIVEXINSTALL" -Name "iexplorer.exe" -value "1" -Force -Verbose
New-Item "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_RESTRICT_FILEDOWNLOAD" -Force
New-ItemProperty -Type String -Path "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_RESTRICT_FILEDOWNLOAD" -Name "explorer.exe" -value "1" -Force -Verbose
New-ItemProperty -Type String -Path "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_RESTRICT_FILEDOWNLOAD" -Name "iexplorer.exe" -value "1" -Force -Verbose
New-Item "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Restrictions" -Force
New-ItemProperty -Type DWord -Path "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Restrictions" -Name "NoCrashDetection" -value "1" -Force -Verbose
New-Item "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Security\ActiveX" -Force
New-ItemProperty -Type DWord -Path "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Security\ActiveX" -Name "BlockNonAdminActiveXInstall" -value "1" -Force -Verbose
New-ItemProperty -Type String -Path "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Main" -Name "Isolation" -value "pmem" -Force -Verbose
New-ItemProperty -Type DWord -Path "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Main" -Name "DisableEPMCompat" -value "1" -Force -Verbose
New-ItemProperty -Type DWord -Path "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Main" -Name "Isolation64Bit" -value "1" -Force -Verbose
New-Item "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap" -Force
New-ItemProperty -Type DWord -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap" -Name "UNCAsIntranet" -value "0" -Force -Verbose
New-Item "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\0" -Force
New-Item "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1" -Force
New-Item "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" -Force
New-Item "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" -Force
New-Item "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\4" -Force
New-ItemProperty -Type DWord -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\0" -Name "1C00" -value "0" -Force -Verbose
New-ItemProperty -Type DWord -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\0" -Name "270C" -value "0" -Force -Verbose
New-ItemProperty -Type DWord -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1" -Name "1C00" -value "65536" -Force -Verbose
New-ItemProperty -Type DWord -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1" -Name "270C" -value "0" -Force -Verbose
New-ItemProperty -Type DWord -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" -Name "1C00" -value "65536" -Force -Verbose
New-ItemProperty -Type DWord -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" -Name "1201" -value "3" -Force -Verbose
New-ItemProperty -Type DWord -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" -Name "270C" -value "0" -Force -Verbose
New-ItemProperty -Type DWord -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" -Name "1001" -value "3" -Force -Verbose
New-ItemProperty -Type DWord -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" -Name "1C00" -value "0" -Force -Verbose
New-ItemProperty -Type DWord -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" -Name "1206" -value "3" -Force -Verbose
New-ItemProperty -Type DWord -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" -Name "1209" -value "3" -Force -Verbose
New-ItemProperty -Type DWord -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" -Name "120b" -value "3" -Force -Verbose
New-ItemProperty -Type DWord -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" -Name "120c" -value "3" -Force -Verbose
New-ItemProperty -Type DWord -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" -Name "1407" -value "3" -Force -Verbose
New-ItemProperty -Type DWord -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" -Name "1409" -value "0" -Force -Verbose
New-ItemProperty -Type DWord -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" -Name "1606" -value "3" -Force -Verbose
New-ItemProperty -Type DWord -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" -Name "1607" -value "3" -Force -Verbose
New-ItemProperty -Type DWord -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" -Name "160A" -value "3" -Force -Verbose
New-ItemProperty -Type DWord -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" -Name "1802" -value "3" -Force -Verbose
New-ItemProperty -Type DWord -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" -Name "1804" -value "3" -Force -Verbose
New-ItemProperty -Type DWord -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" -Name "1A00" -value "65536" -Force -Verbose
New-ItemProperty -Type DWord -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" -Name "1C00" -value "0" -Force -Verbose
New-ItemProperty -Type DWord -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" -Name "2001" -value "3" -Force -Verbose
New-ItemProperty -Type DWord -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" -Name "2004" -value "3" -Force -Verbose
New-ItemProperty -Type DWord -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" -Name "2101" -value "3" -Force -Verbose
New-ItemProperty -Type DWord -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" -Name "2402" -value "3" -Force -Verbose
New-ItemProperty -Type DWord -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" -Name "2500" -value "0" -Force -Verbose
New-ItemProperty -Type DWord -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" -Name "270C" -value "0" -Force -Verbose
New-ItemProperty -Type DWord -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\4" -Name "1206" -value "3" -Force -Verbose
New-ItemProperty -Type DWord -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\4" -Name "120b" -value "3" -Force -Verbose
New-ItemProperty -Type DWord -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\4" -Name "120c" -value "3" -Force -Verbose
New-ItemProperty -Type DWord -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\4" -Name "1209" -value "3" -Force -Verbose
New-ItemProperty -Type DWord -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\4" -Name "1407" -value "3" -Force -Verbose
New-ItemProperty -Type DWord -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\4" -Name "1400" -value "3" -Force -Verbose
New-ItemProperty -Type DWord -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\4" -Name "1409" -value "0" -Force -Verbose
New-ItemProperty -Type DWord -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\4" -Name "160A" -value "3" -Force -Verbose
New-ItemProperty -Type DWord -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\4" -Name "1802" -value "3" -Force -Verbose
New-ItemProperty -Type DWord -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\4" -Name "1A00" -value "196608" -Force -Verbose
New-ItemProperty -Type DWord -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\4" -Name "2001" -value "3" -Force -Verbose
New-ItemProperty -Type DWord -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\4" -Name "2402" -value "3" -Force -Verbose
New-ItemProperty -Type DWord -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\4" -Name "2500" -value "0" -Force -Verbose

# Reg-Keys entfernen
Remove-Item -Path "Registry::HKEY_CLASSES_ROOT\search-ms" -Recurse -Verbose