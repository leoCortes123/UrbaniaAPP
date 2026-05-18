# 🔌 AUTH - Endpoints
## Endpoints del Feature de Autenticación

> **Consultar**: Cuando se implemente el API real o se modifiquen interfaces de datasource.
> **Relacionado con**: `/docs/API_CONTRACT.md`

---

## Base URL
`/auth`

---

## Endpoints

### POST /auth/login
**Descripción**: Autenticación con email y password

**Request**:
```json
{
  "email": "user@example.com",
  "password": "securePassword123"
}
```

**Response 200**:
```json
{
  "success": true,
  "data": {
    "user": {
      "id": "usr_001",
      "name": "Juan Pérez",
      "email": "user@example.com",
      "role": "resident",
      "unit": "Apto 101",
      "avatarUrl": null
    },
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
  }
}
```

**Response 401**:
```json
{
  "success": false,
  "error": {
    "code": "INVALID_CREDENTIALS",
    "message": "Email o contraseña incorrectos"
  }
}
```

---

### POST /auth/register
**Descripción**: Registro de nuevo usuario

**Request**:
```json
{
  "name": "Juan Pérez",
  "email": "user@example.com",
  "phone": "3001234567",
  "unit": "Apto 101",
  "password": "securePassword123",
  "confirmPassword": "securePassword123"
}
```

**Response 201**:
```json
{
  "success": true,
  "data": {
    "user": {
      "id": "usr_002",
      "name": "Juan Pérez",
      "email": "user@example.com",
      "role": "resident",
      "status": "pending_verification"
    }
  }
}
```

---

### POST /auth/logout
**Descripción**: Cerrar sesión

**Headers**:
```
Authorization: Bearer <token>
```

**Response 200**:
```json
{
  "success": true,
  "message": "Sesión cerrada exitosamente"
}
```

---

### GET /auth/me
**Descripción**: Obtener usuario actual

**Headers**:
```
Authorization: Bearer <token>
```

**Response 200**:
```json
{
  "success": true,
  "data": {
    "id": "usr_001",
    "name": "Juan Pérez",
    "email": "user@example.com",
    "role": "resident",
    "unit": "Apto 101"
  }
}
```

---

### POST /auth/social-login
**Descripción**: Login con proveedor social

**Request**:
```json
{
  "provider": "google",
  "token": "ya29.a0AfH6SMBx...",
  "email": "user@gmail.com",
  "name": "Juan Pérez",
  "avatarUrl": "https://lh3.googleusercontent.com/..."
}
```

**Response 200**:
```json
{
  "success": true,
  "data": {
    "user": { ... },
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "isNewUser": false
  }
}
```

---

### POST /auth/forgot-password
**Descripción**: Solicitar recuperación de contraseña

**Request**:
```json
{
  "email": "user@example.com"
}
```

**Response 200**:
```json
{
  "success": true,
  "message": "Se ha enviado un email con instrucciones"
}
```
