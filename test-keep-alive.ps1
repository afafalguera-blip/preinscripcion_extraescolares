# Script para probar manualmente el keep-alive de Supabase
Write-Host "=== Test de Keep-Alive para Supabase ===" -ForegroundColor Cyan
Write-Host ""

# Credenciales de Supabase
$supabaseUrl = "https://zaxbtnjkidqwzqsehvld.supabase.co"
$supabaseKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InpheGJ0bmpraWRxd3pxc2VodmxkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTgwMjc2NTMsImV4cCI6MjA3MzYwMzY1M30.9MNjQdeLvW_UaxZz0XQmR6jQSakzF-UzBWvdboWWHRg"

$apiUrl = "$supabaseUrl/rest/v1/inscripcions?select=id&limit=1"

Write-Host "Enviando peticion a Supabase..." -ForegroundColor Yellow
Write-Host "URL: $apiUrl" -ForegroundColor Gray
Write-Host ""

try {
    $headers = @{
        "apikey" = $supabaseKey
        "Authorization" = "Bearer $supabaseKey"
    }
    
    $response = Invoke-RestMethod -Uri $apiUrl -Method Get -Headers $headers -ErrorAction Stop
    
    Write-Host "[OK] Peticion exitosa!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Respuesta recibida:" -ForegroundColor Cyan
    $response | ConvertTo-Json -Depth 10 | Write-Host
    Write-Host ""
    Write-Host "La conexion a Supabase funciona correctamente." -ForegroundColor Green
    Write-Host "El keep-alive deberia funcionar de la misma manera." -ForegroundColor Green
    
} catch {
    Write-Host "[ERROR] Error al conectar con Supabase:" -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
    
    if ($_.Exception.Response) {
        $statusCode = $_.Exception.Response.StatusCode.value__
        Write-Host "Codigo de estado HTTP: $statusCode" -ForegroundColor Yellow
        
        try {
            $errorStream = $_.Exception.Response.GetResponseStream()
            $reader = New-Object System.IO.StreamReader($errorStream)
            $errorBody = $reader.ReadToEnd()
            Write-Host "Detalles del error:" -ForegroundColor Yellow
            Write-Host $errorBody -ForegroundColor Gray
        } catch {
            Write-Host "No se pudo leer el cuerpo del error." -ForegroundColor Yellow
        }
    }
}

Write-Host ""
Write-Host "=== Informacion adicional ===" -ForegroundColor Cyan
Write-Host ""
Write-Host "1. Para verificar en GitHub Actions:" -ForegroundColor White
Write-Host "   https://github.com/afafalguera-blip/preinscripcion_extraescolares/actions" -ForegroundColor Gray
Write-Host "   Busca el workflow 'Keep Supabase Alive' y verifica las ejecuciones." -ForegroundColor Gray
Write-Host ""
Write-Host "2. Para ejecutar manualmente el workflow:" -ForegroundColor White
Write-Host "   Ve a Actions > Keep Supabase Alive > Run workflow" -ForegroundColor Gray
Write-Host ""
Write-Host "3. Para ver logs en Supabase:" -ForegroundColor White
Write-Host "   https://supabase.com/dashboard/project/zaxbtnjkidqwzqsehvld/logs/api" -ForegroundColor Gray
Write-Host ""
Write-Host "4. Estado de la base de datos:" -ForegroundColor White
Write-Host "   https://supabase.com/dashboard/project/zaxbtnjkidqwzqsehvld" -ForegroundColor Gray
Write-Host "   La base de datos NO deberia estar pausada si recibe peticiones regularmente." -ForegroundColor Gray
