# Path to the wallpaper file
$wallpaperPath = "C:\Intel\Wallpaper.jpg"

# Change the wallpaper
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop\" -Name "Wallpaper" -Value $wallpaperPath

# Refresh the wallpaper setting
rundll32.exe user32.dll, UpdatePerUserSystemParameters
