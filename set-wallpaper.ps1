# URL of the online image
$imageUrl = "https://images.unsplash.com/photo-1506744038136-46273834b3fb"
$savePath = "$env:TEMP\desktop_wallpaper.jpg"

# Download the image
Write-Host "Downloading wallpaper..."
Invoke-WebRequest -Uri $imageUrl -OutFile $savePath

# Set wallpaper via Windows API
Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;

public class WallpaperSetter {
    [DllImport("user32.dll", CharSet = CharSet.Auto)]
    public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
}
"@

$SPI_SETDESKWALLPAPER = 20
$SPIF_UPDATEINIFILE = 0x01
$SPIF_SENDCHANGE = 0x02

[WallpaperSetter]::SystemParametersInfo($SPI_SETDESKWALLPAPER, 0, $savePath, $SPIF_UPDATEINIFILE -bor $SPIF_SENDCHANGE)
Write-Host "Wallpaper updated successfully!" -ForegroundColor Green