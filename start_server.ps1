# Steve's Diamond Catch - Native Windows PowerShell Web Server
# Works out-of-the-box on all Windows systems even without Python or Node installed!

$port = 8080

# Auto-detect primary Wi-Fi / LAN IPv4 address
$ip = $null
try {
    $ip = (Get-NetIPAddress -AddressFamily IPv4 | Where-Object { 
        $_.InterfaceAlias -notlike "*Loopback*" -and 
        $_.InterfaceAlias -notlike "*vEthernet*" -and 
        $_.IPAddress -notlike "169.254*" 
    } | Select-Object -First 1).IPAddress
} catch {}

if (-not $ip) {
    try {
        $ip = [System.Net.Dns]::GetHostAddresses([System.Net.Dns]::GetHostName()) | 
              Where-Object { $_.AddressFamily -eq 'InterNetwork' -and $_.IPAddressToString -notlike "127.*" } | 
              Select-Object -First 1 -ExpandProperty IPAddressToString
    } catch {}
}

if (-not $ip) { $ip = "localhost" }

Write-Host "=======================================================" -ForegroundColor Cyan
Write-Host "   STEVE'S DIAMOND CATCH - WINDOWS SERVER (PowerShell) " -ForegroundColor Green
Write-Host "=======================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host " 1. Make sure your smartphone and PC are on the same Wi-Fi."
Write-Host " 2. On your iPhone or Android phone, open:" -ForegroundColor Yellow
Write-Host ""
Write-Host "    👉   http://$($ip):$($port)   👈" -ForegroundColor White -BackgroundColor DarkGreen
Write-Host ""
Write-Host " 3. Tap 'Add to Home Screen' for full-screen mode!"
Write-Host ""
Write-Host " Press Ctrl+C in this window to stop the server."
Write-Host "=======================================================" -ForegroundColor Cyan
Write-Host ""

# Prefer Python if installed for speed
if (Get-Command python -ErrorAction SilentlyContinue) {
    python -m http.server $port
    exit
}
if (Get-Command py -ErrorAction SilentlyContinue) {
    py -m http.server $port
    exit
}

# Built-in .NET HttpListener (zero third-party dependencies required)
$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://*:$port/")
try {
    $listener.Start()
} catch {
    # If binding to wildcard requires admin elevation, fallback to localhost and specific IP
    $listener.Prefixes.Clear()
    $listener.Prefixes.Add("http://localhost:$port/")
    if ($ip -ne "localhost") {
        try { $listener.Prefixes.Add("http://${ip}:$port/") } catch {}
    }
    $listener.Start()
}

$root = $PSScriptRoot

while ($listener.IsListening) {
    try {
        $context = $listener.GetContext()
        $request = $context.Request
        $response = $context.Response

        $localPath = $request.Url.LocalPath
        if ($localPath -eq "/" -or [string]::IsNullOrEmpty($localPath)) {
            $localPath = "/index.html"
        }
        $filePath = Join-Path $root ($localPath.TrimStart('/'))

        if (Test-Path $filePath -PathType Leaf) {
            $bytes = [System.IO.File]::ReadAllBytes($filePath)
            $ext = [System.IO.Path]::GetExtension($filePath).ToLower()
            $contentType = switch ($ext) {
                ".html" { "text/html; charset=utf-8" }
                ".js"   { "application/javascript; charset=utf-8" }
                ".json" { "application/json; charset=utf-8" }
                ".svg"  { "image/svg+xml" }
                ".css"  { "text/css; charset=utf-8" }
                default { "application/octet-stream" }
            }
            $response.ContentType = $contentType
            $response.ContentLength64 = $bytes.Length
            $response.OutputStream.Write($bytes, 0, $bytes.Length)
        } else {
            $response.StatusCode = 404
            $notFound = [System.Text.Encoding]::UTF8.GetBytes("404 Not Found")
            $response.OutputStream.Write($notFound, 0, $notFound.Length)
        }
        $response.Close()
    } catch {
        # Handle client connection interrupts
    }
}
