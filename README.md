# E-Commerce Microservicios

Plataforma de e-commerce basada en microservicios con Spring Boot y PostgreSQL.

## Integrantes

| Nombre | Correo |
|--------|--------|
| Felipe Zapata | fe.zapatao@duocuc.cl |

## Descripcion del proyecto

Sistema de comercio electronico compuesto por 9 microservicios independientes, cada uno con su propia base de datos PostgreSQL. La arquitectura permite gestionar el ciclo completo de compra:

- **Catalogo y usuarios**: gestion de productos y registro de usuarios
- **Carrito e inventario**: control de stock en tiempo real y carrito de compras con validacion de disponibilidad
- **Ordenes y pagos**: creacion de ordenes con calculo automatico de totales, procesamiento de pagos con actualizacion de estado de la orden (PENDING, CONFIRMED, CANCELLED)
- **Notificaciones**: generacion automatica de notificaciones al crear ordenes, confirmar pagos o realizar reembolsos
- **Wishlist y reviews**: lista de deseos y resenas de productos con validacion de existencia via Feign
- **Comunicacion entre servicios**: los microservicios se comunican via Spring Cloud OpenFeign para validar datos y orquestar flujos de negocio
- **API Gateway con JWT**: unico punto de entrada (puerto 8080). Enruta a los microservicios, valida los tokens y expone login/registro en `/auth`
- **Observabilidad**: logs estructurados en JSON enviados a Loki, trazas distribuidas en Tempo y visualizacion correlacionada en Grafana
- **Migraciones**: todas las tablas se crean automaticamente con Flyway al levantar los servicios

## Requisitos

- [Docker Desktop](https://www.docker.com/products/docker-desktop/) instalado y corriendo
- Git

## Levantar el proyecto

**Windows:**
```cmd
git clone https://github.com/dunedains/ecommers-infra.git
cd ecommers-infra
setup.bat
docker compose up --build
```

**Mac/Linux:**
```bash
git clone https://github.com/dunedains/ecommers-infra.git
cd ecommers-infra
chmod +x setup.sh && ./setup.sh
docker compose up --build
```

> La primera vez tarda varios minutos porque Maven descarga las dependencias y construye cada imagen.

## Puntos de acceso

Solo el **gateway** y las herramientas de observabilidad publican puerto. Los 9 microservicios
ya **no son accesibles directamente**: todo el trafico entra por el gateway en `http://localhost:8080`.

| Componente   | URL                              | Descripcion                          |
|--------------|----------------------------------|--------------------------------------|
| Gateway      | http://localhost:8080            | Punto de entrada (API + `/auth`)     |
| Swagger UI   | http://localhost:8080/swagger-ui.html | Documentacion agregada de los 9 servicios |
| Grafana      | http://localhost:3000            | Logs + trazas (usuario anonimo, admin/admin) |
| Tempo        | http://localhost:3200            | Consulta de trazas                   |
| Loki         | http://localhost:3100            | Consulta de logs                     |

### Microservicios (internos)

| Servicio       | Puerto interno | Descripción                  |
|----------------|----------------|------------------------------|
| productos      | 8081           | Catálogo de productos        |
| users          | 8082           | Gestión de usuarios          |
| whitelist      | 8083           | Lista de deseos              |
| reviews        | 8084           | Reseñas de productos         |
| inventory      | 8085           | Control de inventario        |
| cart           | 8086           | Carrito de compras           |
| orders         | 8087           | Gestión de órdenes           |
| pagos          | 8088           | Procesamiento de pagos       |
| notifications  | 8089           | Notificaciones en tiempo real|

## Pruebas rápidas (a traves del gateway)

```bash
# 1. Registrar un usuario y obtener un token JWT
curl -X POST http://localhost:8080/auth/register \
  -H "Content-Type: application/json" \
  -d '{"name":"Juan","email":"juan@mail.com","address":"Calle 123","password":"secret123"}'

# 2. (o iniciar sesion) -> devuelve {"token":"...", ...}
curl -X POST http://localhost:8080/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"juan@mail.com","password":"secret123"}'

# 3. Usar el token en las peticiones protegidas
TOKEN="<pega-el-token-aqui>"
curl -X POST http://localhost:8080/api/orders \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"userId":1,"productId":1,"quantity":1}'

# 4. Ver logs y trazas correlacionados en Grafana (http://localhost:3000)
```

## Detener el proyecto

```bash
docker compose down
```

Para eliminar también los datos de la base de datos:

```bash
docker compose down -v
```
