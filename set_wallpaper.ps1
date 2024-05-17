#Change the execution policy for the current PowerShell session
#Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process

# Path to the wallpaper file
$wallpaperPath = "C:\Intel\Wallpaper.jpg"

# Get the SID of the current logged-in user
$currentUser = Get-WmiObject -Class Win32_ComputerSystem | Select-Object -ExpandProperty UserName
$userSid = (New-Object System.Security.Principal.NTAccount($currentUser)).Translate([System.Security.Principal.SecurityIdentifier]).Value

# Path to the user's wallpaper registry key
$regPath = "Registry::HKEY_USERS\$userSid\Control Panel\Desktop"

# Set the wallpaper
Set-ItemProperty -Path $regPath -Name "Wallpaper" -Value $wallpaperPath
Set-ItemProperty -Path $regPath -Name "WallpaperStyle" -Value "2"  # Fill
Set-ItemProperty -Path $regPath -Name "TileWallpaper" -Value "0"  # No tiling

# Refresh the wallpaper setting
$signature = @'
[DllImport("user32.dll", CharSet = CharSet.Auto)]
public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
'@

$User32 = Add-Type -MemberDefinition $signature -Name "User32" -Namespace Win32Functions -PassThru
$SPI_SETDESKWALLPAPER = 0x0014
$SPIF_UPDATEINIFILE = 0x01
$SPIF_SENDWININICHANGE = 0x02

$User32::SystemParametersInfo($SPI_SETDESKWALLPAPER, 0, $wallpaperPath, $SPIF_UPDATEINIFILE -bor $SPIF_SENDWININICHANGE)
