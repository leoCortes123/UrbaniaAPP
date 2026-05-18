# HomeScreen

## Objetivo
Pantalla principal de la aplicación orientada a mostrar:
- saludo al usuario
- notificaciones rápidas
- accesos directos a módulos principales
- navigation bar inferior con 4 vinculos a modulos principales

La pantalla debe ser completamente estática y sin scroll.

---

# Estructura General

## Configuración Base
- Sin scroll general
- Uso obligatorio de SafeArea
- Layout dividido en 4 secciones verticales
- Sin bordes visibles entre secciones
- Fondo con patrones orgánicos/irregulares organic shapes o blob shapes para separar visualmente las áreas
- Responsive para móviles y tablets
- Todos los estilos visuales deben provenir del tema global y design system existente

---

# Distribución Vertical

| Sección | Altura |
|---|---|
| Banner principal | 30% |
| Carrusel de notificaciones | 30% |
| Navegación principal | 40% |
| Botton navigation bar | fijo |

---

# Sección 1 — Banner Principal

## Objetivo
Mostrar saludo principal, foto de perfil de usuario y datos basicos unidad

## Elementos

### Foto de perfil
- Ubicación:
  derecha
- Forma circular
- Placeholder temporal permitido

### Texto de bienvenida
- Texto:
  "¡Hola, **Nombre del usuario**!"
- Ubicación:
  izquierda


## Fondo
- Sin fondo

---

# Sección 2 — Carrusel de Notificaciones

## Objetivo
Mostrar carousel de tarjetas de notificaciones destacadas.

## Elementos
- Carrusel horizontal centrado
- Tarjeta principal visible y centrada
- Tarjetas siguiente y anterios parcialmente visibles a los lados de la tarjeta principal
- Tarjetas semitransparentes
- Informacion: Titulo de notificacion, texto notificacion, tipo notificacion, fecha notificacion

## Reglas
- No agregar texto
- No agregar iconos
- No agregar botones
- Solo deben verse las tarjetas del carrusel

## Comportamiento
- Scroll únicamente interno del carrusel
- La pantalla principal continúa siendo estática

---

# Sección 3 — Navegación Principal

## Objetivo
Mostrar accesos rápidos a los módulos principales.

## Layout
- Grid centrado
- 3 columnas por fila

## Botones
- Forma cuadrada
- Bordes redondeados
- Icono superior
- Texto inferior

## Pantallas

1. Estado
2. Pagos
3. Visitas
4. Parqueadero
5. Reservas
6. Comunidad
7. Eventos
8. Configuracion
9. Contactanos

---

# Botton navigation bar

## Objetivo
Mostrar una barra estatica con 4 vinculos a pantallas principales

## Pantallas

1. Inicio
2. Pagos
3. Notificaciones
4. Visitas

# Restricciones Técnicas

- No usar SingleChildScrollView
- No usar ListView principal
- Mantener separación entre UI y lógica
- Preparado para integración futura con providers/viewmodels
- Componentes reutilizables obligatorios
- Todos los estilos deben consumirse desde el sistema global de diseño

---
