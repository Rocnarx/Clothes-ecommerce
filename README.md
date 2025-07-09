
# 👕 Clothes Custom Shop

> Plataforma web integral para la venta y personalización de camisetas, con un catálogo dinámico de ropa, carrito de compras, autenticación de usuarios y gestión de estampas artísticas. Diseñada para ofrecer una experiencia interactiva y moderna.

---

## 🚀 Características Principales

- 🛒 Catálogo interactivo de productos con imágenes, descripciones y filtros por tipo, categoría y precio.
- 🎨 Personalización de camisetas con estampas únicas y variedad de colores y tallas.
- 👥 Registro e inicio de sesión con roles diferenciados (usuarios y administradores).
- 🧑‍🎨 Panel de gestión para artistas con administración de estampas.
- 📊 Panel administrativo con estadísticas de ventas y productos populares.
- 📦 Carrito de compras con resumen dinámico y proceso de compra sencillo.
- 🌐 Interfaz responsiva y amigable para móviles.
- 🔄 Comunicación frontend-backend mediante API REST.

---

## 🧑‍💻 Tecnologías Utilizadas

| Área          | Herramientas Principales                      |
|---------------|-----------------------------------------------|
| 💻 Frontend   | HTML5, CSS3, JavaScript |
| 🛠️ Backend    | Node.js |
| 🗃️ Base de Datos | MySQL |
| 🎨 Estilos    | CSS personalizado  |
| 🔐 Seguridad  | Autenticación por roles con variables `.env` |

---

## 🏗️ Estructura del Proyecto

```plaintext
clothes-custom-shop/
│
├── frontend/        → Cliente web en React
├── backend/         → Servidor Express con API REST
├── db_scripts/      → Scripts SQL para MySQL o PostgreSQL
└── README.md        → Documentación del proyecto
```

---

## 📦 Requisitos Previos

- Node.js y npm actualizados
- Instancia MySQL (o PostgreSQL)
- Editor como VSCode
- Git para clonar el repositorio

---

## ⚙️ Instalación

1. Clona el repositorio:

   ```bash
   git clone https://github.com/tu-usuario/clothes-custom-shop.git
   ```

2. Instala dependencias:

   ```bash
   cd frontend && npm install
   cd ../backend && npm install
   ```

3. Configura variables de entorno en `backend/.env` (usa `.env.example` como referencia).

4. Ejecuta los scripts SQL de `db_scripts` en tu servidor de base de datos.

---

## ▶️ Ejecución

### 1. Base de Datos
- Asegúrate de que el servicio de base de datos esté activo.
- Ejecuta los scripts para crear las tablas.

### 2. Backend
```bash
cd backend
npm start
```

### 3. Frontend
```bash
cd frontend
npm start
```

---

## 💡 Lecciones Aprendidas

- Desarrollo modular y mantenimiento de una arquitectura escalable.
- Integración frontend-backend mediante servicios REST.
- Personalización de UI/UX para distintos dispositivos.
- Gestión de roles y permisos en un sistema e-commerce.

---

## 📌 Estado del Proyecto

🚧 **En desarrollo (WIP)**

---

## 🤝 Autores

- Cristian Andres Cruz Puentes – `20221020125`  
- Juan Diego Grajales Castillo – `20221020128`  
- Luis Felipe Mayorga Tibaquicha – `20221020134`  
- Christian Camilo Lancheros Sanchez – `20222020061`

---

## 📄 Licencia

Este proyecto está bajo la [Licencia GNU GPL v3.0](https://www.gnu.org/licenses/gpl-3.0.html).

---
