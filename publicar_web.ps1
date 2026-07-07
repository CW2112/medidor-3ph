# ============================================================================
#  publicar_web.ps1  -  Publica/actualiza el dashboard en GitHub Pages.
#
#  Copia la ultima version del dashboard desde el proyecto y la sube al repo
#  medidor-3ph. GitHub Pages se reconstruye solo en ~1 minuto.
#
#  Uso:  click derecho -> Ejecutar con PowerShell   (o)   .\publicar_web.ps1
# ============================================================================
# "Continue": los warnings de git (LF/CRLF) escriben a stderr y no deben abortar.
$ErrorActionPreference = "Continue"
$repo = "C:\Users\carlo\Solucion-Claude\medidor-3ph-web"
$fuente = "C:\Users\carlo\Solucion-Claude\esp32s3_eth_medidor\dashboard_nube.html"

Set-Location $repo
Copy-Item $fuente ".\index.html" -Force

git add -A
$cambios = git status --porcelain
if (-not $cambios) {
    Write-Host "Sin cambios: el dashboard ya esta publicado." -ForegroundColor Yellow
    exit 0
}
git commit -m ("Actualiza dashboard " + (Get-Date -Format "yyyy-MM-dd HH:mm")) | Out-Null
git push
Write-Host ""
Write-Host "Publicado. En ~1 min: https://cw2112.github.io/medidor-3ph/" -ForegroundColor Green
