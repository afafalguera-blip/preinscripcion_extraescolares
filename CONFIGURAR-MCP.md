# 🔌 Configuración de MCP (Model Context Protocol) con Supabase

Se ha configurado la conexión MCP entre Supabase y Cursor usando tu token de acceso.

## ✅ Configuración Realizada

### 1. Token Configurado
- **Token MCP**: `sbp_f1c50c2414239a5df09b595f58c89047a69ff947`
- **Proyecto Supabase**: `zaxbtnjkidqwzqsehvld.supabase.co`

### 2. Archivo de Configuración

La configuración se ha añadido al archivo de settings de Cursor:
```
C:\Users\Administrator\AppData\Roaming\Cursor\User\settings.json
```

La configuración incluye:
```json
{
  "mcpServers": {
    "supabase": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-supabase"
      ],
      "env": {
        "SUPABASE_ACCESS_TOKEN": "sbp_f1c50c2414239a5df09b595f58c89047a69ff947"
      }
    }
  }
}
```

## 🔄 Próximos Pasos

1. **Reiniciar Cursor:**
   - Cierra completamente Cursor
   - Vuelve a abrirlo para que cargue la nueva configuración MCP

2. **Verificar la Conexión:**
   - Una vez reiniciado, deberías poder usar las herramientas MCP de Supabase directamente desde Cursor
   - Puedes probar haciendo consultas a tu base de datos usando comandos MCP

3. **Verificar el Proyecto:**
   - Asegúrate de que el token está asociado al proyecto correcto: `zaxbtnjkidqwzqsehvld.supabase.co`
   - Si el token apunta a otro proyecto, necesitarás obtener un token del proyecto correcto

## 🛠️ Funcionalidades Disponibles

Con MCP configurado, podrás:

- ✅ Listar tablas en Supabase
- ✅ Ejecutar consultas SQL
- ✅ Ver logs de la API
- ✅ Gestionar migraciones
- ✅ Generar tipos TypeScript
- ✅ Gestionar Edge Functions
- ✅ Y mucho más...

## 🔍 Verificar que Funciona

1. Abre Cursor después de reiniciarlo
2. Intenta usar comandos relacionados con Supabase
3. Las herramientas MCP deberían estar disponibles automáticamente

## 📝 Notas Importantes

- **Token de Acceso**: El token MCP de Supabase (`sbp_...`) es diferente de la clave anónima (anon key) que usas en tu aplicación web
- **Seguridad**: El token está almacenado en tu configuración local de Cursor
- **Permisos**: Asegúrate de que el token tiene los permisos necesarios para acceder a tu proyecto

## 🆘 Solución de Problemas

### Si MCP no funciona después de reiniciar:

1. **Verifica que Node.js esté instalado:**
   ```powershell
   node --version
   npx --version
   ```

2. **Instala el servidor MCP manualmente si es necesario:**
   ```powershell
   npm install -g @modelcontextprotocol/server-supabase
   ```

3. **Verifica el token:**
   - Ve al dashboard de Supabase
   - Verifica que el token es válido y tiene acceso al proyecto correcto

4. **Revisa los logs de Cursor:**
   - Ve a la consola de desarrollador de Cursor
   - Busca errores relacionados con MCP

## 📚 Referencias

- [Documentación de MCP](https://modelcontextprotocol.io/)
- [Supabase MCP Server](https://github.com/supabase/mcp-server-supabase)
- [Dashboard de Supabase](https://supabase.com/dashboard/project/zaxbtnjkidqwzqsehvld)

