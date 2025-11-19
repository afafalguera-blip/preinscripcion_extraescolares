# 🔍 Cómo Verificar que el Keep-Alive Funciona

Hay varias formas de verificar que el sistema de keep-alive está funcionando correctamente:

## 1. ✅ Verificar en GitHub Actions (Recomendado)

### Ver ejecuciones del workflow:

1. Ve a tu repositorio en GitHub:
   ```
   https://github.com/afafalguera-blip/preinscripcion_extraescolares
   ```

2. Haz clic en la pestaña **"Actions"**

3. Busca el workflow **"Keep Supabase Alive"**

4. Deberías ver:
   - ✅ Ejecuciones programadas diarias a las 8:00 AM UTC
   - ✅ Estado "Success" (verde) si funciona correctamente
   - ✅ Logs de cada ejecución mostrando la respuesta de Supabase

### Ejecutar manualmente para probar:

1. En la pestaña **Actions**
2. Selecciona **"Keep Supabase Alive"** del menú lateral
3. Haz clic en **"Run workflow"** (botón a la derecha)
4. Selecciona la rama `main`
5. Haz clic en **"Run workflow"**
6. Espera unos segundos y verifica que el workflow se ejecuta correctamente

**Qué buscar en los logs:**
- Si ves una respuesta JSON con datos de la tabla `inscripcions` → ✅ Funciona correctamente
- Si ves un error 401/403 → ❌ Problema con las credenciales (secrets)
- Si ves un error 404 → ❌ La URL de Supabase es incorrecta

## 2. 🔬 Probar manualmente con el script de prueba

Ejecuta el script de prueba local:

```powershell
cd preinscripcion_extraescolares
pwsh -ExecutionPolicy Bypass -File .\test-keep-alive.ps1
```

Este script hace exactamente lo mismo que el workflow de GitHub Actions y te mostrará si la conexión funciona.

## 3. 📊 Verificar en el Dashboard de Supabase

### Ver el estado de la base de datos:

1. Ve al dashboard de Supabase:
   ```
   https://supabase.com/dashboard/project/zaxbtnjkidqwzqsehvld
   ```

2. Verifica el estado del proyecto:
   - Si dice **"Active"** o **"Running"** → ✅ La base de datos está activa
   - Si dice **"Paused"** o **"Inactive"** → ⚠️ La base de datos está pausada

3. **Panel de estado:**
   - En la página principal del proyecto deberías ver el estado
   - Si está pausada, aparecerá un botón para reactivarla

### Ver logs de API (solo en planes Pro):

1. Ve a **Logs** → **API Logs** en el dashboard
2. Filtra por fecha para ver las peticiones recientes
3. Busca peticiones GET a `/rest/v1/inscripcions`
4. Si ves peticiones diarias desde direcciones IP de GitHub Actions → ✅ El keep-alive funciona

**Nota:** Los logs de API solo están disponibles en planes pagos. En el plan gratuito, puedes verificar el estado de la base de datos pero no los logs detallados.

## 4. ⏰ Verificar la hora de ejecución

El workflow se ejecuta todos los días a las **8:00 AM UTC**.

**Zonas horarias de referencia:**
- 8:00 AM UTC = 9:00 AM CET (Central European Time)
- 8:00 AM UTC = 4:00 AM EDT (Eastern Daylight Time)
- 8:00 AM UTC = 1:00 AM PDT (Pacific Daylight Time)

**Cómo verificar la última ejecución:**

1. En GitHub Actions, mira la fecha y hora de la última ejecución del workflow "Keep Supabase Alive"
2. Debería ejecutarse aproximadamente a la misma hora todos los días

## 5. 🧪 Probar la conexión directamente con curl

Si quieres probar manualmente desde tu terminal:

```powershell
$url = "https://zaxbtnjkidqwzqsehvld.supabase.co/rest/v1/inscripcions?select=id&limit=1"
$key = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InpheGJ0bmpraWRxd3pxc2VodmxkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTgwMjc2NTMsImV4cCI6MjA3MzYwMzY1M30.9MNjQdeLvW_UaxZz0XQmR6jQSakzF-UzBWvdboWWHRg"

curl -X GET $url -H "apikey: $key" -H "Authorization: Bearer $key"
```

Deberías ver una respuesta JSON con datos de la tabla.

## 🎯 Indicadores de que TODO funciona correctamente:

✅ **En GitHub Actions:**
- El workflow "Keep Supabase Alive" se ejecuta exitosamente
- Aparece un check verde cada día
- Los logs muestran una respuesta exitosa (código 200)

✅ **En Supabase:**
- El proyecto muestra estado "Active" o "Running"
- La base de datos NO está pausada
- Puedes hacer consultas normalmente

✅ **Comportamiento esperado:**
- La base de datos se mantiene activa incluso sin tráfico de usuarios
- No recibes notificaciones de pausa automática de Supabase
- Puedes acceder a los datos en cualquier momento

## ❌ Señales de que algo NO funciona:

❌ **En GitHub Actions:**
- El workflow falla con errores
- Aparece una X roja
- Los logs muestran errores 401, 403, o 404

❌ **En Supabase:**
- El proyecto está "Paused" o "Inactive"
- No puedes acceder a los datos
- Recibes notificaciones de pausa automática

## 🔧 Solución de problemas:

### Si el workflow falla:

1. **Verifica los secrets:**
   - Ve a: `https://github.com/afafalguera-blip/preinscripcion_extraescolares/settings/secrets/actions`
   - Confirma que existen `SUPABASE_URL` y `SUPABASE_ANON_KEY`
   - Verifica que los valores sean correctos

2. **Re-ejecuta el workflow manualmente:**
   - Actions → Keep Supabase Alive → Run workflow
   - Esto te permitirá ver los errores en tiempo real

3. **Verifica la URL y la clave:**
   - Confirma que la URL es: `https://zaxbtnjkidqwzqsehvld.supabase.co`
   - Confirma que la clave anónima es la correcta desde el dashboard de Supabase

### Si la base de datos está pausada:

1. Ve al dashboard de Supabase
2. Haz clic en el botón para reactivar el proyecto
3. Ejecuta manualmente el workflow para verificar que funciona
4. Espera a la próxima ejecución programada (8:00 AM UTC del día siguiente)

## 📅 Calendario de ejecuciones:

El workflow se ejecuta automáticamente según este horario:

- **Día 1:** 8:00 AM UTC
- **Día 2:** 8:00 AM UTC
- **Día 3:** 8:00 AM UTC
- ... y así sucesivamente

**Nota importante:** GitHub Actions tiene una ligera variación en la hora de ejecución (puede ser unos minutos antes o después de las 8:00 AM UTC), pero siempre se ejecutará una vez al día.

