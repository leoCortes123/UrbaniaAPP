# 📋 FEATURES_INDEX
## Catálogo de Features del Proyecto Urbania

> **Consultar**: Si es un feature nuevo o modificación de feature existente.
> **Actualizar**: Cada vez que se agrega, completa o modifica un feature.

---

## Estado de Features

| # | Feature | Prioridad | Estado | Dependencias | Archivo de Spec | Demo Ready |
|---|---------|-----------|--------|--------------|-----------------|------------|
| 1 | Autenticación | P0 | Completado | — | `features/auth/auth.md` | Login con credenciales demo |
| 2 | Home Dashboard | P0 | En desarrollo | Auth | `features/home/home.md` | Métricas locales |
| 3 | Profile | P1 | Pendiente | Auth | `features/profile/profile.md` | Datos residente actual |
| 4 | Reservations | P1 | Pendiente | Auth | `features/reservations/reservations.md` | CRUD local |
| 5 | Payments | P1 | Pendiente | Auth | `features/payments/payments.md` | Historial mock |
| 6 | PQRS | P1 | Pendiente | Auth | `features/pqrs/pqrs.md` | Crear + listar local |
| 7 | Notifications | P2 | Pendiente | Auth | `features/notifications/notifications.md` | Lista local |
| 8 | Chat | P2 | Pendiente | Auth | `features/chat/chat.md` | Mensajes demo |
| 9 | Admin Panel | P1 | Pendiente | Auth | `features/admin/admin.md` | Solo rol admin |

> **Nota**: Los features marcados como "Pendiente" aún no tienen documentación de spec.
> El agente debe crear el archivo de spec siguiendo el formato de `features/auth/auth.md`
> antes de implementar el feature.

---

## Recursos de Diseño por Feature

> **IMPORTANTE**: Cada feature cuenta con recursos de diseño generados con Google Stitch. Antes de implementar o modificar una pantalla, DEBES consultar estos documentos para entender el diseño visual exacto:

| Feature | Carpeta de Recursos | Archivos |
|---------|-------------------|----------|
| Autenticación | `features/auth/recursos/` | `DESIGN.md`, `code.html`, `screen.png` |
| Home Dashboard | `features/home/recursos/` | `DESIGN.md`, `code.html`, `screen.png` |

**Para cada recurso**:
- `code.html` → Mockup interactivo (fuente visual de verdad)
- `DESIGN.md` → Especificaciones técnicas (colores, tipografía, spacing)
- `screen.png` → Captura estática del diseño

### Checklist de Diseño al Crear/Modificar Feature

- [ ] Revisar `code.html` para entender layout y comportamiento visual exacto
- [ ] Consultar `DESIGN.md` para tokens de diseño (colores, spacing, tipografía)
- [ ] Implementar usando los tokens del THEME_SYSTEM.md actualizados
- [ ] Verificar que el resultado coincida con `screen.png`

---

## Definición de Prioridades

- **P0**: Bloqueante para MVP. Sin esto no hay app.
- **P1**: Core functionality. Necesario para lanzamiento.
- **P2**: Value-add. Puede esperar a post-lanzamiento.

---

## Demo Features (Modo Offline)

### Credenciales de Acceso Rápido
```
Admin:    admin@urbania.demo / Urbania2026!
Resident: residente@urbania.demo / Residente2026!
```

> **Nota**: Solo 2 credenciales funcionan en modo demo. Los 8 residentes generados en demo data
> son para mostrar datos de ejemplo (lista de residentes, reservas, etc.), pero solo 2 pueden
> iniciar sesión. Esto es intencional para simplificar el flujo de demo.

### Datos Pre-cargados
- **1 Propiedad**: Conjunto Residencial Los Pinos (48 unidades)
- **8 Residentes**: Generados con faker (1 admin, 7 residentes) — solo 2 pueden loguear
- **2 Reservas**: Salón Social y Piscina
- **Pagos**: Historial de 6 meses
- **PQRS**: 3 casos de ejemplo
- **Notificaciones**: 5 notificaciones recientes
- **Chat**: Conversación demo con administración

---

> **⚠️ Ubicación correcta**: Todo spec de feature debe ir en `/docs/features/[feature]/[feature].md`.
> Ver `DIRECTORY_STRUCTURE.md` para la guía completa de organización.

## Checklist al Agregar/Modificar Feature

- [ ] Revisar recursos de diseño en `/docs/features/[feature]/recursos/` (code.html, DESIGN.md, screen.png)
- [ ] Actualizar tabla de estado en este documento
- [ ] Crear/actualizar spec en `/docs/features/[feature]/[feature].md`
- [ ] Crear/actualizar endpoints en `/docs/features/[feature]/endpoints.md`
- [ ] Verificar que no excede prioridad sin dependencias resueltas
- [ ] Agregar datos mock en `core/demo/demo_data.dart` si aplica
- [ ] Actualizar DEMO_SETUP.md si cambia persistencia local
- [ ] Actualizar ROUTING.md si agrega/modifica rutas

> **Diseño Visual**: NO implementar UI basándose en suposiciones. Los recursos de diseño en la carpeta `recursos/` son la fuente de verdad para el aspecto visual de cada pantalla.

---

> **Recuerda**: En caso de creación o modificación de features, actualizar el archivo de endpoints correspondiente (`/docs/features/[feature]/endpoints.md`). Toma como ejemplo de formato el documento `/docs/features/auth/endpoints.md`.
