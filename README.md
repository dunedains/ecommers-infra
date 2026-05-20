# E-Commerce Microservicios

Plataforma de e-commerce basada en microservicios con Spring Boot y PostgreSQL.

## Requisitos

- [Docker Desktop](https://www.docker.com/products/docker-desktop/) instalado y corriendo
- Git

## Levantar el proyecto

```bash
# 1. Clonar este repo
git clone https://github.com/dunedains/ecommers-infra.git
cd ecommers-infra

# 2. Clonar los microservicios
chmod +x setup.sh && ./setup.sh

# 3. Levantar todo
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
