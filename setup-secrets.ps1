# Script para configurar secrets de GitHub Actions usando GitHub CLI
$ErrorActionPreference = "Stop"

Write-Host "=== Configuración de Secrets para GitHub Actions ===" -ForegroundColor Cyan
Write-Host ""

# Valores de Supabase
$supabaseUrl = "https://zaxbtnjkidqwzqsehvld.supabase.co"
# IMPORTANTE: Configura tu Supabase Anon Key antes de ejecutar
# Puedes usar variable de entorno: $env:SUPABASE_ANON_KEY = 'tu_key'
$supabaseKey = $env:SUPABASE_ANON_KEY
if (-not $supabaseKey) {
    Write-Host "ERROR: Variable de entorno SUPABASE_ANON_KEY no configurada." -ForegroundColor Red
    Write-Host "Configura tu anon key con: `$env:SUPABASE_ANON_KEY = 'tu_key'" -ForegroundColor Yellow
    exit 1
}

# Token de GitHub (Personal Access Token)
# IMPORTANTE: Configura tu GitHub token antes de ejecutar
# Puedes usar variable de entorno: $env:GITHUB_TOKEN = 'tu_token'
$githubToken = $env:GITHUB_TOKEN
if (-not $githubToken) {
    Write-Host "ERROR: Variable de entorno GITHUB_TOKEN no configurada." -ForegroundColor Red
    Write-Host "Configura tu token con: `$env:GITHUB_TOKEN = 'tu_token'" -ForegroundColor Yellow
    exit 1
}

Write-Host "Verificando GitHub CLI..." -ForegroundColor Yellow

# Verificar si gh está instalado
$ghInstalled = Get-Command gh -ErrorAction SilentlyContinue

if (-not $ghInstalled) {
    Write-Host "GitHub CLI no está instalado." -ForegroundColor Yellow
    Write-Host "Intentando instalar con winget..." -ForegroundColor Yellow
    
    try {
        winget install --id GitHub.cli -e --silent --accept-package-agreements --accept-source-agreements
        Write-Host "✓ GitHub CLI instalado" -ForegroundColor Green
        Write-Host "Esperando 5 segundos para que se actualice el PATH..." -ForegroundColor Yellow
        Start-Sleep -Seconds 5
        
        # Refrescar PATH - usar refresco manual si es necesario
        $machinePath = [System.Environment]::GetEnvironmentVariable('Path', 'Machine')
        $userPath = [System.Environment]::GetEnvironmentVariable('Path', 'User')
        $env:Path = "$machinePath;$userPath"
    } catch {
        Write-Host "Error instalando GitHub CLI: $_" -ForegroundColor Red
        Write-Host "Por favor instálalo manualmente desde: https://cli.github.com/" -ForegroundColor Yellow
        exit 1
    }
}

# Autenticar con GitHub usando el token
Write-Host "Autenticando con GitHub..." -ForegroundColor Yellow
$env:GH_TOKEN = $githubToken

try {
    # Verificar autenticación
    gh auth status 2>&1 | Out-Null
    if ($LASTEXITCODE -ne 0) {
        # Autenticar usando el token
        echo $githubToken | gh auth login --with-token
        Write-Host "✓ Autenticado con GitHub" -ForegroundColor Green
    } else {
        Write-Host "✓ Ya estás autenticado con GitHub" -ForegroundColor Green
    }
} catch {
    Write-Host "Configurando autenticación..." -ForegroundColor Yellow
    echo $githubToken | gh auth login --with-token 2>&1 | Out-Null
    Write-Host "✓ Autenticado con GitHub" -ForegroundColor Green
}

# Configurar los secrets
Write-Host ""
Write-Host "Configurando secrets..." -ForegroundColor Yellow

try {
    # Configurar SUPABASE_URL
    Write-Host "Configurando SUPABASE_URL..." -ForegroundColor Cyan
    echo $supabaseUrl | gh secret set SUPABASE_URL --repo afafalguera-blip/preinscripcion_extraescolares
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ SUPABASE_URL configurado correctamente" -ForegroundColor Green
    } else {
        Write-Host "✗ Error configurando SUPABASE_URL" -ForegroundColor Red
    }
    
    # Configurar SUPABASE_ANON_KEY
    Write-Host "Configurando SUPABASE_ANON_KEY..." -ForegroundColor Cyan
    echo $supabaseKey | gh secret set SUPABASE_ANON_KEY --repo afafalguera-blip/preinscripcion_extraescolares
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ SUPABASE_ANON_KEY configurado correctamente" -ForegroundColor Green
    } else {
        Write-Host "✗ Error configurando SUPABASE_ANON_KEY" -ForegroundColor Red
    }
    
    Write-Host ""
    Write-Host "=== Configuración completada ===" -ForegroundColor Green
    Write-Host ""
    Write-Host "Puedes verificar los secrets en:" -ForegroundColor Cyan
    Write-Host "https://github.com/afafalguera-blip/preinscripcion_extraescolares/settings/secrets/actions" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "El workflow Keep Supabase Alive se ejecutará automáticamente todos los días a las 8:00 AM UTC" -ForegroundColor Cyan
    
} catch {
    Write-Host "Error configurando secrets: $_" -ForegroundColor Red
    Write-Host ""
    Write-Host "Alternativa: Puedes configurarlos manualmente en:" -ForegroundColor Yellow
    Write-Host "https://github.com/afafalguera-blip/preinscripcion_extraescolares/settings/secrets/actions" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Valores a configurar:" -ForegroundColor Yellow
    Write-Host "SUPABASE_URL: $supabaseUrl" -ForegroundColor White
    Write-Host "SUPABASE_ANON_KEY: $supabaseKey" -ForegroundColor White
}
