# 🚀 Ejecutar el Workflow Keep-Alive Manualmente

Los cambios han sido subidos a GitHub. Ahora puedes ejecutar el workflow manualmente para verificar que Supabase detecta la conexión correctamente.

## ✅ Estado Actual

- ✅ Workflow mejorado y subido a GitHub
- ✅ Secrets configurados en GitHub (`SUPABASE_URL` y `SUPABASE_ANON_KEY`)
- ✅ Workflow listo para ejecutarse

## 🎯 Cómo Ejecutar el Workflow Manualmente

### Opción 1: Desde la Interfaz Web de GitHub (Recomendado)

1. **Ve a tu repositorio:**
   ```
   https://github.com/afafalguera-blip/preinscripcion_extraescolares
   ```

2. **Haz clic en la pestaña "Actions"** (arriba en el menú)

3. **Busca el workflow "Keep Supabase Alive"** en el menú lateral izquierdo

4. **Haz clic en "Run workflow"** (botón azul a la derecha)

5. **Selecciona:**
   - **Branch**: `main`
   - Haz clic en el botón verde **"Run workflow"**

6. **Espera unos segundos** y verás que aparece una nueva ejecución

7. **Haz clic en la ejecución** para ver los logs en tiempo real

### Opción 2: URL Directa

Puedes ir directamente a:
```
https://github.com/afafalguera-blip/preinscripcion_extraescolares/actions/workflows/keep-alive.yml
```

Y hacer clic en **"Run workflow"**

## 📊 Qué Esperar en los Logs

Si todo funciona correctamente, deberías ver:

```
🔄 Ejecutando keep-alive para Supabase...
📅 Fecha y hora: 2025-01-XX XX:XX:XX UTC

📡 Respuesta recibida:
[
  {
    "id": "xxxx-xxxx-xxxx-xxxx"
  }
]

✅ Estado HTTP: 200
✅ Keep-alive ejecutado correctamente. Supabase está activo.
```

## ✅ Verificar en Supabase

Después de ejecutar el workflow:

1. **Ve al dashboard de Supabase:**
   ```
   https://supabase.com/dashboard/project/zaxbtnjkidqwzqsehvld
   ```

2. **Verifica el estado:**
   - El proyecto debería estar **"Active"** o **"Running"**
   - No debería estar pausado

3. **Verifica actividad (si tienes plan Pro):**
   - Ve a **Logs** → **API Logs**
   - Deberías ver una petición GET reciente a `/rest/v1/inscripcions`
   - La IP debería ser de GitHub Actions (172.x.x.x o similar)

## 🔍 Verificar que Funciona Correctamente

### Indicadores de Éxito:

✅ **En GitHub Actions:**
- El workflow aparece con un check verde ✅
- Los logs muestran "✅ Keep-alive ejecutado correctamente"
- Estado HTTP 200 en los logs

✅ **En Supabase:**
- El proyecto no está pausado
- Puedes hacer consultas normalmente
- No recibes notificaciones de pausa

### Si hay Errores:

❌ **Error 401/403:**
- Los secrets no están configurados correctamente
- Verifica en: Settings → Secrets and variables → Actions

❌ **Error 404:**
- La URL de Supabase es incorrecta
- Verifica que el secret `SUPABASE_URL` es correcto

❌ **Workflow falla:**
- Revisa los logs completos en GitHub Actions
- Verifica que los secrets existan y sean correctos

## 📅 Próximas Ejecuciones Automáticas

El workflow se ejecutará automáticamente:
- **Cada hora (minuto 0)**
- Así mantiene actividad constante para evitar pausas por inactividad.

No necesitas hacer nada más. El workflow se ejecutará automáticamente y mantendrá tu base de datos activa.

## 🔗 Enlaces Útiles

- **Repositorio**: https://github.com/afafalguera-blip/preinscripcion_extraescolares
- **Actions**: https://github.com/afafalguera-blip/preinscripcion_extraescolares/actions
- **Workflow**: https://github.com/afafalguera-blip/preinscripcion_extraescolares/actions/workflows/keep-alive.yml
- **Secrets**: https://github.com/afafalguera-blip/preinscripcion_extraescolares/settings/secrets/actions
- **Dashboard Supabase**: https://supabase.com/dashboard/project/zaxbtnjkidqwzqsehvld

