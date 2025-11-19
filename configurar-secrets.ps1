# Script simplificado para configurar secrets usando curl y GitHub API
param()

$ErrorActionPreference = "Continue"

Write-Host "=== Configuracion de Secrets para GitHub Actions ===" -ForegroundColor Cyan
Write-Host ""

# Credenciales
# IMPORTANTE: Configura estos valores antes de ejecutar el script
# Puedes usar variables de entorno o editarlos directamente aquí
$githubToken = $env:GITHUB_TOKEN
if (-not $githubToken) {
    Write-Host "ERROR: Variable de entorno GITHUB_TOKEN no configurada." -ForegroundColor Red
    Write-Host "Configura tu token de GitHub con: `$env:GITHUB_TOKEN = 'tu_token'" -ForegroundColor Yellow
    Write-Host "O edita este script y añade tu token directamente." -ForegroundColor Yellow
    exit 1
}

$owner = "afafalguera-blip"
$repo = "preinscripcion_extraescolares"

$supabaseUrl = "https://zaxbtnjkidqwzqsehvld.supabase.co"
$supabaseKey = $env:SUPABASE_ANON_KEY
if (-not $supabaseKey) {
    Write-Host "ERROR: Variable de entorno SUPABASE_ANON_KEY no configurada." -ForegroundColor Red
    Write-Host "Configura tu anon key con: `$env:SUPABASE_ANON_KEY = 'tu_key'" -ForegroundColor Yellow
    Write-Host "O edita este script y añade tu key directamente." -ForegroundColor Yellow
    exit 1
}

# Verificar si curl está disponible
$curlAvailable = Get-Command curl -ErrorAction SilentlyContinue

if (-not $curlAvailable) {
    Write-Host "curl no esta disponible. Usando Invoke-RestMethod..." -ForegroundColor Yellow
    $useCurl = $false
} else {
    Write-Host "Usando curl..." -ForegroundColor Yellow
    $useCurl = $true
}

# Obtener clave publica del repositorio
Write-Host "Obteniendo clave publica del repositorio..." -ForegroundColor Yellow
$publicKeyUrl = "https://api.github.com/repos/$owner/$repo/actions/secrets/public-key"

$headers = @{
    "Authorization" = "token $githubToken"
    "Accept" = "application/vnd.github.v3+json"
}

try {
    if ($useCurl) {
        $publicKeyResponse = curl -s -H "Authorization: token $githubToken" -H "Accept: application/vnd.github.v3+json" $publicKeyUrl
        $publicKey = $publicKeyResponse | ConvertFrom-Json
    } else {
        $publicKey = Invoke-RestMethod -Uri $publicKeyUrl -Headers $headers -Method Get
    }
    
    Write-Host "Clave publica obtenida: $($publicKey.key_id)" -ForegroundColor Green
} catch {
    Write-Host "Error obteniendo clave publica: $_" -ForegroundColor Red
    Write-Host "Verificando si tienes permisos para configurar secrets..." -ForegroundColor Yellow
    exit 1
}

# Para cifrar el secret, necesitamos LibSodium que no esta disponible por defecto en PowerShell
# Usaremos GitHub CLI si esta disponible, o proporcionaremos instrucciones manuales
Write-Host ""
Write-Host "Nota: Los secrets deben cifrarse con LibSodium usando la clave publica." -ForegroundColor Yellow
Write-Host "La forma mas sencilla es usar GitHub CLI (gh)." -ForegroundColor Yellow
Write-Host ""

# Verificar si gh esta instalado
$ghInstalled = Get-Command gh -ErrorAction SilentlyContinue

if ($ghInstalled) {
    Write-Host "GitHub CLI encontrado. Configurando secrets..." -ForegroundColor Green
    Write-Host ""
    
    # Autenticar con el token
    $env:GH_TOKEN = $githubToken
    echo $githubToken | gh auth login --with-token 2>&1 | Out-Null
    
    # Configurar SUPABASE_URL
    Write-Host "Configurando SUPABASE_URL..." -ForegroundColor Cyan
    echo $supabaseUrl | gh secret set SUPABASE_URL --repo $owner/$repo 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "[OK] SUPABASE_URL configurado" -ForegroundColor Green
    } else {
        Write-Host "[ERROR] No se pudo configurar SUPABASE_URL" -ForegroundColor Red
    }
    
    # Configurar SUPABASE_ANON_KEY
    Write-Host "Configurando SUPABASE_ANON_KEY..." -ForegroundColor Cyan
    echo $supabaseKey | gh secret set SUPABASE_ANON_KEY --repo $owner/$repo 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "[OK] SUPABASE_ANON_KEY configurado" -ForegroundColor Green
    } else {
        Write-Host "[ERROR] No se pudo configurar SUPABASE_ANON_KEY" -ForegroundColor Red
    }
    
    Write-Host ""
    Write-Host "=== Configuracion completada ===" -ForegroundColor Green
    
} else {
    Write-Host "GitHub CLI no esta instalado." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Opciones:" -ForegroundColor Cyan
    Write-Host "1. Instalar GitHub CLI:" -ForegroundColor White
    Write-Host "   winget install --id GitHub.cli" -ForegroundColor Gray
    Write-Host ""
    Write-Host "2. Configurar manualmente en:" -ForegroundColor White
    Write-Host "   https://github.com/$owner/$repo/settings/secrets/actions" -ForegroundColor Gray
    Write-Host ""
    Write-Host "Valores a configurar:" -ForegroundColor Yellow
    Write-Host "  SUPABASE_URL: $supabaseUrl" -ForegroundColor White
    Write-Host "  SUPABASE_ANON_KEY: $supabaseKey" -ForegroundColor White
    Write-Host ""
    
    # Intentar instalar GitHub CLI
    $installChoice = Read-Host "¿Deseas intentar instalar GitHub CLI ahora? (S/N)"
    if ($installChoice -eq "S" -or $installChoice -eq "s") {
        Write-Host "Instalando GitHub CLI..." -ForegroundColor Yellow
        winget install --id GitHub.cli -e 2>&1 | Out-Null
        if ($LASTEXITCODE -eq 0) {
            Write-Host "[OK] GitHub CLI instalado. Por favor, ejecuta este script nuevamente." -ForegroundColor Green
        } else {
            Write-Host "[ERROR] No se pudo instalar GitHub CLI automaticamente." -ForegroundColor Red
            Write-Host "        Instalalo manualmente desde: https://cli.github.com/" -ForegroundColor Yellow
        }
    }
}

