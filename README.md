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
- **Logs estructurados**: cada servicio escribe logs a archivo con rotacion diaria, montados via volumenes Docker para ser consumidos por herramientas externas
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

## Microservicios

| Servicio       | Puerto | Descripción                        |
|----------------|--------|------------------------------------|
| productos      | 8081   | Catálogo de productos              |
| users          | 8082   | Gestión de usuarios                |
| whitelist      | 8083   | Lista de deseos                    |
| reviews        | 8084   | Reseñas de productos               |
| inventory      | 8085   | Control de inventario              |
| cart           | 8086   | Carrito de compras                 |
| orders         | 8087   | Gestión de órdenes                 |
| pagos          | 8088   | Procesamiento de pagos             |
| notifications  | 8089   | Notificaciones en tiempo real      |

## Pruebas rápidas

```bash
# Crear un usuario
curl -X POST http://localhost:8082/api/v1/users \
  -H "Content-Type: application/json" \
  -d '{"name":"Juan","email":"juan@mail.com","address":"Calle 123"}'

# Crear una orden
curl -X POST http://localhost:8087/api/orders \
  -H "Content-Type: application/json" \
  -d '{"userId":1,"productId":1,"quantity":1}'

# Procesar pago
curl -X POST http://localhost:8088/api/payments \
  -H "Content-Type: application/json" \
  -d '{"orderId":1,"userId":1,"amount":1499.99,"method":"TRANSFER"}'

# Ver notificaciones del usuario 1
curl http://localhost:8089/api/notifications/user/1
```

## Detener el proyecto

```bash
docker compose down
```

Para eliminar también los datos de la base de datos:

```bash
docker compose down -v
```
