<#
PlayerAuctions Website Server (ASCII-safe)
This script runs a simple local web server using HttpListener.
#>

$port = 8000
$rootPath = "c:\Users\marti\Desktop\site\playerauctions.netlify.app"

$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:$port/")
$listener.Prefixes.Add("http://127.0.0.1:$port/")

try {
    $listener.Start()
    Write-Host "Server started successfully." -ForegroundColor Green
    Write-Host "URLs:" -ForegroundColor Yellow
    Write-Host "  http://localhost:$port" -ForegroundColor Cyan
    Write-Host "  http://127.0.0.1:$port" -ForegroundColor Cyan
    Write-Host "Serving from: $rootPath" -ForegroundColor Gray
    Write-Host "Press Ctrl+C to stop" -ForegroundColor Red

    while ($true) {
        $context = $listener.GetContext()
        $request = $context.Request
        $response = $context.Response

        try {
            $path = $request.Url.LocalPath
            if ($path -eq '/') { $path = '/working-site.html' }

            $filePath = Join-Path $rootPath $path.Substring(1)

            if (Test-Path $filePath -PathType Leaf) {
                $extension = [System.IO.Path]::GetExtension($filePath).ToLower()
                switch ($extension) {
                    '.html' { $response.ContentType = 'text/html' }
                    '.css'  { $response.ContentType = 'text/css' }
                    '.js'   { $response.ContentType = 'application/javascript' }
                    '.json' { $response.ContentType = 'application/json' }
                    '.png'  { $response.ContentType = 'image/png' }
                    '.jpg'  { $response.ContentType = 'image/jpeg' }
                    '.gif'  { $response.ContentType = 'image/gif' }
                    '.ico'  { $response.ContentType = 'image/x-icon' }
                    '.svg'  { $response.ContentType = 'image/svg+xml' }
                    default { $response.ContentType = 'application/octet-stream' }
                }

                $content = [System.IO.File]::ReadAllBytes($filePath)
                $response.StatusCode = 200
                $response.OutputStream.Write($content, 0, $content.Length)
                Write-Host "$(Get-Date -Format 'HH:mm:ss') - 200 OK - $path" -ForegroundColor Green
            } else {
                $response.StatusCode = 404
                $content = [System.Text.Encoding]::UTF8.GetBytes("<html><body><h1>404 - Not Found</h1><p>The requested file was not found.</p></body></html>")
                $response.OutputStream.Write($content, 0, $content.Length)
                Write-Host "$(Get-Date -Format 'HH:mm:ss') - 404 Not Found - $path" -ForegroundColor Red
            }
        } catch {
            $response.StatusCode = 500
            $content = [System.Text.Encoding]::UTF8.GetBytes("Internal Server Error")
            $response.OutputStream.Write($content, 0, $content.Length)
            Write-Host "$(Get-Date -Format 'HH:mm:ss') - 500 Error - $($_.Exception.Message)" -ForegroundColor Red
        } finally {
            $response.Close()
        }
    }
} finally {
    if ($listener) {
        $listener.Stop()
        $listener.Close()
    }
    Write-Host "Server stopped." -ForegroundColor Yellow
}