# 🔌 Conexiones MCP con Supabase

Actualmente tienes **2 conexiones MCP** configuradas con Supabase en Cursor.

## 📊 Conexiones Configuradas

### 1. **supabase_escuelahockey**
- **Proyecto**: `lcypsdpzwcsftgrhurrc`
- **URL**: `https://lcypsdpzwcsftgrhurrc.supabase.co`
- **Método**: Conexión directa por URL con `project_ref`
- **Configuración**: En `mcp.json` usando formato URL

### 2. **supabase_afa** (AFA Escola Falguera)
- **Proyecto**: `zaxbtnjkidqwzqsehvld`
- **URL**: `https://zaxbtnjkidqwzqsehvld.supabase.co`
- **Método**: Conexión usando token MCP
- **Token**: `sbp_f1c50c2414239a5df09b595f58c89047a69ff947`
- **Configuración**: En `mcp.json` usando formato command/npx con token

## 📁 Archivo de Configuración

La configuración está en:
```
C:\Users\Administrator\.cursor\mcp.json
```

## 🔄 Cómo Funciona

Cuando uses las herramientas MCP de Supabase en Cursor:

- **Si no especificas un servidor**: Se usará el servidor por defecto (probablemente el primero configurado)
- **Para acceder al proyecto específico**: Puedes especificar qué servidor usar según la tarea

## ✅ Verificar las Conexiones

Para verificar que ambas conexiones funcionan:

1. **Reinicia Cursor** completamente
2. **Intenta usar herramientas MCP** relacionadas con Supabase
3. **Verifica en el dashboard de Supabase** que puedes acceder a ambos proyectos

## 🔧 Notas Importantes

### Diferencias entre los dos métodos:

**Formato URL (supabase_escuelahockey):**
- ✅ Más simple y directo
- ✅ Se conecta directamente al proyecto específico
- ⚠️ Requiere el `project_ref` en la URL

**Formato Token (supabase_afa):**
- ✅ Más flexible - permite acceder a múltiples proyectos
- ✅ Usa el token MCP de Supabase
- ✅ Puede acceder a todos los proyectos asociados al token
- ⚠️ Requiere Node.js y npx instalados

### Si el token no funciona con el proyecto correcto:

Si el token `sbp_f1c50c2414239a5df09b595f58c89047a69ff947` no te da acceso al proyecto `zaxbtnjkidqwzqsehvld`, puedes:

1. **Obtener un nuevo token MCP** desde el dashboard de Supabase para ese proyecto específico
2. **O usar el mismo formato URL** que la primera conexión:
   ```json
   "supabase_afa": {
     "url": "https://mcp.supabase.com/mcp?project_ref=zaxbtnjkidqwzqsehvld",
     "headers": {}
   }
   ```

## 🎯 Recomendación

Si ambas conexiones usan el mismo formato, es más fácil de mantener. Puedes actualizar `supabase_afa` para usar el formato URL también:

```json
"supabase_afa": {
  "url": "https://mcp.supabase.com/mcp?project_ref=zaxbtnjkidqwzqsehvld",
  "headers": {}
}
```

Esto funcionará igual de bien y será más consistente con la primera conexión.

## 📚 Referencias

- [Dashboard Supabase Escola Hockey](https://supabase.com/dashboard/project/lcypsdpzwcsftgrhurrc)
- [Dashboard Supabase AFA](https://supabase.com/dashboard/project/zaxbtnjkidqwzqsehvld)

