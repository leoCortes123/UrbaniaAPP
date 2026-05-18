# 📁 ESTRUCTURA DE DIRECTORIOS DE DOCUMENTACIÓN

> **Este documento es la guía maestra de organización.**
> Todo agente de desarrollo DEBE seguir esta estructura estrictamente.
> Los documentos fuera de su ubicación correcta serán ignorados.

---

## Árbol Completo

```
/docs/
├── AGENTS_GUIDE.md              ← Mapa de navegación (SIEMPRE primero)
├── GOLDEN_RULES.md            ← Reglas inquebrantables
├── ARCHITECTURE.md            ← Stack, estructura, principios
├── THEME_SYSTEM.md            ← Colores, tipografía, componentes base
├── ALERT_SYSTEM.md            ← Alertas, notificaciones, estados
├── ROUTING.md                 ← Navegación, rutas, GoRouter
├── FEATURES_INDEX.md          ← Catálogo de features y estado
├── DEVELOPMENT_GUIDE.md     ← Setup, flujo de trabajo, convenciones
├── DEMO_SETUP.md              ← Modo offline, credenciales, mock data
├── API_CONTRACT.md            ← Referencia futura (backend)
├── IMPLEMENTATION_REPORT.md   ← Historial de iteraciones (solo lectura)
│
├── DIRECTORY_STRUCTURE.md   ← ESTE DOCUMENTO
│
└── /features/
    │
    ├── /auth/
    │   ├── auth.md              ← Spec completo del feature
    │   ├── endpoints.md         ← Endpoints del feature
    │   └── /recursos/           ← Diseño visual (SOLO auth y home tienen recursos por ahora)
    │       ├── DESIGN.md        ← Especificaciones técnicas del diseño
    │       ├── code.html        ← Mockup interactivo (fuente visual de verdad)
    │       └── screen.png       ← Captura estática
    │
    ├── /home/
    │   ├── home.md              ← Spec completo del feature
    │   └── /recursos/
    │       ├── DESIGN.md
    │       ├── code.html
    │       └── screen.png
    │
    ├── /profile/
    │   └── profile.md           ← (Pendiente - crear al implementar)
    │
    ├── /reservations/
    │   └── reservations.md      ← (Pendiente - crear al implementar)
    │
    ├── /payments/
    │   └── payments.md          ← (Pendiente - crear al implementar)
    │
    ├── /pqrs/
    │   └── pqrs.md              ← (Pendiente - crear al implementar)
    │
    ├── /notifications/
    │   └── notifications.md     ← (Pendiente - crear al implementar)
    │
    ├── /chat/
    │   └── chat.md              ← (Pendiente - crear al implementar)
    │
    └── /admin/
        └── admin.md             ← (Pendiente - crear al implementar)
```

---

## Reglas de Ubicación

| Tipo de documento | Ubicación obligatoria | Ejemplo |
|-------------------|----------------------|---------|
| **Guía general** | `/docs/` raíz | `AGENTS_GUIDE.md` |
| **Spec de feature** | `/docs/features/[feature]/[feature].md` | `/docs/features/auth/auth.md` |
| **Endpoints de feature** | `/docs/features/[feature]/endpoints.md` | `/docs/features/auth/endpoints.md` |
| **Recursos de diseño** | `/docs/features/[feature]/recursos/` | `/docs/features/auth/recursos/code.html` |
| **Reporte de implementación** | `/docs/IMPLEMENTATION_REPORT.md` | Solo lectura, no modificar |

---

## Flujo de Trabajo por Tipo de Tarea (con rutas exactas)

### Implementar feature nuevo:
```
/docs/AGENTS_GUIDE.md
  → /docs/GOLDEN_RULES.md
  → /docs/ARCHITECTURE.md
  → /docs/THEME_SYSTEM.md
  → /docs/ALERT_SYSTEM.md
  → /docs/FEATURES_INDEX.md
  → /docs/DEVELOPMENT_GUIDE.md
  → /docs/DEMO_SETUP.md
  → /docs/features/[feature]/[feature].md     ← CREAR si no existe
  → /docs/features/[feature]/endpoints.md        ← CREAR si no existe
  → /docs/features/[feature]/recursos/code.html  ← CONSULTAR antes de codear UI
```

### Modificar feature existente:
```
/docs/AGENTS_GUIDE.md
  → /docs/GOLDEN_RULES.md
  → /docs/ARCHITECTURE.md
  → /docs/features/[feature]/[feature].md
  → /docs/DEVELOPMENT_GUIDE.md
  → /docs/ALERT_SYSTEM.md (si hay mensajes nuevos)
```

### Crear componente UI nuevo:
```
/docs/AGENTS_GUIDE.md
  → /docs/GOLDEN_RULES.md
  → /docs/ARCHITECTURE.md
  → /docs/THEME_SYSTEM.md
  → /docs/FEATURES_INDEX.md (recursos de diseño)
  → /docs/features/[feature]/recursos/code.html  ← FUENTE VISUAL DE VERDAD
  → /docs/ALERT_SYSTEM.md
  → /docs/DEVELOPMENT_GUIDE.md
```

---

## Referencias Cruzadas Correctas

Al referenciar otro documento, usar SIEMPRE la ruta relativa desde `/docs/`:

| Desde | Referencia correcta | Referencia incorrecta |
|-------|--------------------|----------------------|
| `auth.md` | `Ver ROUTING.md` | `Ver /ROUTING.md` |
| `AGENTS_GUIDE.md` | `Ver features/auth/auth.md` | `Ver auth.md` |
| `FEATURES_INDEX.md` | `Ver features/home/recursos/DESIGN.md` | `Ver DESIGN.md` |
| Cualquier feature | `Ver ../THEME_SYSTEM.md` | `Ver THEME_SYSTEM.md` |

---

## Checklist al Crear/Modificar Feature

- [ ] Crear `/docs/features/[feature]/[feature].md` siguiendo formato de `features/auth/auth.md`
- [ ] Crear `/docs/features/[feature]/endpoints.md` siguiendo formato de `features/auth/endpoints.md`
- [ ] Actualizar tabla de estado en `/docs/FEATURES_INDEX.md`
- [ ] Si hay UI nueva, crear `/docs/features/[feature]/recursos/` con `DESIGN.md`, `code.html`, `screen.png`
- [ ] Verificar que no hay documentos huérfanos (creados fuera de su carpeta)
- [ ] Verificar que todas las referencias cruzadas usan rutas correctas

---

> **⚠️ IMPORTANTE**: Los documentos de feature (auth.md, home.md) NUNCA deben estar en la raíz de `/docs/`. 
> Su ubicación correcta es SIEMPRE `/docs/features/[feature]/[feature].md`.
