# Description: Boxstarter Script  
# Author: Laurent Kempé
# Dev settings for my app development

Disable-UAC

#--- Windows Features ---
Set-WindowsExplorerOptions -EnableShowHiddenFilesFoldersDrives -EnableShowProtectedOSFiles -EnableShowFileExtensions

#--- File Explorer Settings ---
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneExpandToCurrentFolder -Value 1
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneShowAllFolders -Value 1
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name LaunchTo -Value 1
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name MMTaskbarMode -Value 2

#--- Uninstall unecessary applications that come with Windows out of the box ---
Write-Host "Uninstall some applications that come with Windows out of the box" -ForegroundColor "Yellow"

function removeApp {
	Param ([string]$appName)
	Write-Output "Trying to remove $appName"
	Get-AppxPackage $appName -AllUsers | Remove-AppxPackage
	Get-AppXProvisionedPackage -Online | Where DisplayName -like $appName | Remove-AppxProvisionedPackage -Online
}

$Applications = @(
	"Microsoft.BingFinance",
	"Microsoft.3DBuilder",
	"Microsoft.BingNews",
	"Microsoft.BingSports",
	"Microsoft.BingWeather",
	"Microsoft.CommsPhone",
	"Microsoft.Getstarted",
	"Microsoft.WindowsMaps",
	"*MarchofEmpires*",
	"Microsoft.GetHelp",
	"Microsoft.Messaging",
	"*Minecraft*",
	"Microsoft.MicrosoftOfficeHub",
	"Microsoft.OneConnect",
	"Microsoft.WindowsPhone",
	"Microsoft.WindowsSoundRecorder",
	"*Solitaire*",
#	"Microsoft.MicrosoftStickyNotes",
	"Microsoft.Office.Sway",
	"Microsoft.NetworkSpeedTest",
	"Microsoft.FreshPaint",
	"Microsoft.Print3D",
	"Microsoft.Wallet",                            # Wallet
	"Microsoft.OneConnect",                        # Xbox
	"Microsoft.StorePurchaseApp",                  # Xbox
	"Microsoft.XboxIdentityProvider",              # Xbox
	"Microsoft.XboxGameOverlay",                   # Xbox
	"Microsoft.XboxSpeechToTextOverlay",           # Xbox
	"Microsoft.Xbox.TCUI",                         # Xbox
	"Microsoft.Office.Sway",                       # Sway
	"*Autodesk*",
	"*BubbleWitch*",
	"king.com*",
	"*Plex*"
);

foreach ($app in $Applications) {
    removeApp $app
}

#--- Windows Subsystems/Features ---
choco install -y Microsoft-Hyper-V-All -source windowsFeatures
choco install -y Microsoft-Windows-Subsystem-Linux -source windowsfeatures

#--- Docker ---
Enable-WindowsOptionalFeature -Online -FeatureName containers -All
RefreshEnv
choco install -y docker-for-windows 

#--- Define Packages to Install ---
$Packages = 'git',`
            'poshgit',`
            'kdiff3',`
            'vscode',`
            'vscode-docker',`
            'notepadplusplus',`
            'nodejs',`
            'FiraCode',`
            'SourceTree',`
            'snoop',`
            'fiddler',`
            'keepass',`
            'cmdermini',`
            '7zip',`
            'ngrok.portable',`
            'winscp',`
            'GoogleChrome',`
	    'firefox',`
            'paint.net',`
            'rapidee',`
            'sharex',`
            'SwissFileKnife',`
            'sysinternals',`
            'windirstat',`
            'rufus',`
            'netfx-4.7-devpack'

#--- Install Packages ---
ForEach ($PackageName in $Packages)
{choco install $PackageName -y}

Enable-UAC
Enable-MicrosoftUpdate
Install-WindowsUpdate -acceptEula
