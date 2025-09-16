# AFA Escola Falguera - Sistema de Actividades Extraescolares

Sistema completo para la gestión de inscripciones de actividades extraescolares de la AFA Escola Falguera.

## 📋 Características

### Formulario de Preinscripción (`index.html`)
- ✅ **Bilingüe** (Catalán/Español) con banderas
- ✅ **Responsive** - Funciona en móviles y escritorio
- ✅ **Validación** de formularios en tiempo real
- ✅ **Integración con Supabase** para almacenar datos
- ✅ **Selección dinámica** de actividades según el curso
- ✅ **Información de precios** y métodos de pago
- ✅ **Autorizaciones** (imagen, salud, salida)

### Panel de Administración (`admin.html`)
- ✅ **Dashboard** con estadísticas en tiempo real
- ✅ **Lista completa** de inscripciones
- ✅ **Filtros** por curso, actividad y búsqueda
- ✅ **Paginación** para grandes volúmenes de datos
- ✅ **Vista detallada** de cada inscripción
- ✅ **Exportación a CSV** de los datos
- ✅ **Eliminación** de inscripciones
- ✅ **Actualización** en tiempo real

## 🚀 Instalación y Configuración

### 1. Configurar Supabase

1. Crea una cuenta en [Supabase](https://supabase.com)
2. Crea un nuevo proyecto
3. Ve a **Settings** → **API** y copia:
   - **Project URL**
   - **Anon public key**

### 2. Crear la tabla en Supabase

Ejecuta este SQL en el **SQL Editor** de Supabase:

```sql
CREATE TABLE inscripcions (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    student_name TEXT NOT NULL,
    student_surname TEXT NOT NULL,
    student_course TEXT NOT NULL,
    parent_name TEXT NOT NULL,
    parent_dni TEXT NOT NULL,
    parent_phone_1 TEXT NOT NULL,
    parent_phone_2 TEXT,
    parent_email_1 TEXT NOT NULL,
    parent_email_2 TEXT,
    afa_member BOOLEAN NOT NULL,
    health_info TEXT,
    activities TEXT[] NOT NULL,
    image_auth_consent TEXT NOT NULL,
    can_leave_alone BOOLEAN NOT NULL,
    authorized_pickup TEXT,
    conditions_accepted BOOLEAN NOT NULL,
    form_language TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

### 3. Configurar las credenciales

Edita los archivos `index.html` y `admin.html` y reemplaza:

```javascript
const SUPABASE_URL = "TU_URL_DE_SUPABASE";
const SUPABASE_KEY = "TU_ANON_KEY_DE_SUPABASE";
```

### 4. Subir a GitHub Pages

1. Crea un repositorio en GitHub
2. Sube todos los archivos:
   - `index.html` (formulario principal)
   - `admin.html` (panel de administración)
   - `navigation.html` (página de navegación)
   - `README.md` (este archivo)

3. Activa GitHub Pages:
   - Ve a **Settings** → **Pages**
   - Source: **Deploy from a branch**
   - Branch: **main**
   - Folder: **/ (root)**

4. Tu sitio estará disponible en:
   `https://TU_USUARIO.github.io/NOMBRE_REPOSITORIO`

## 📁 Estructura de archivos

```
tu-repositorio/
├── index.html          # Formulario de preinscripción
├── admin.html          # Panel de administración
├── navigation.html     # Página de navegación
└── README.md          # Documentación
```

## 🔧 Funcionalidades del Panel de Administración

### Dashboard
- **Total de inscripciones**
- **Número de socios AFA**
- **Número de no socios**
- **Actividad más popular**

### Gestión de Datos
- **Filtros avanzados** por curso y actividad
- **Búsqueda** por nombre del alumno
- **Paginación** para manejar grandes volúmenes
- **Vista detallada** de cada inscripción
- **Exportación a CSV** con todos los datos

### Seguridad
- **Acceso directo** al panel (considera añadir autenticación)
- **Eliminación** con confirmación
- **Validación** de datos en tiempo real

## 🌐 URLs de Acceso

- **Formulario público**: `https://tu-usuario.github.io/tu-repositorio/`
- **Panel de administración**: `https://tu-usuario.github.io/tu-repositorio/admin.html`
- **Página de navegación**: `https://tu-usuario.github.io/tu-repositorio/navigation.html`

## 📱 Responsive Design

El sistema está optimizado para:
- 📱 **Móviles** (320px+)
- 📱 **Tablets** (768px+)
- 💻 **Escritorio** (1024px+)

## 🎨 Personalización

### Colores
Los colores principales se pueden cambiar editando las clases de Tailwind CSS:
- **Azul principal**: `blue-600`, `blue-700`
- **Verde secundario**: `green-600`, `green-700`
- **Grises**: `gray-50`, `gray-100`, etc.

### Textos
Todos los textos están en las variables de traducción en JavaScript.

## 🔒 Consideraciones de Seguridad

1. **Panel de administración**: Actualmente es público. Considera añadir autenticación.
2. **Base de datos**: Usa las políticas de Supabase para controlar el acceso.
3. **Validación**: Los datos se validan tanto en frontend como en backend.

## 📞 Soporte

Para cualquier duda o problema:
1. Revisa la consola del navegador para errores
2. Verifica la configuración de Supabase
3. Comprueba que las credenciales sean correctas

## 📄 Licencia

Este proyecto está desarrollado específicamente para la AFA Escola Falguera.
