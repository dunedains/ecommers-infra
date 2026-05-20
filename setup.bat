@echo off
echo Clonando microservicios...

git clone https://github.com/dunedains/ecommers-productos.git
git clone https://github.com/dunedains/ecommers-user.git
git clone https://github.com/dunedains/ecommers-whiltelist.git
git clone https://github.com/dunedains/ecommers-reviw.git
git clone https://github.com/dunedains/ecommers-Inventory.git
git clone https://github.com/dunedains/ecommers-cart.git
git clone https://github.com/dunedains/ecommers-order.git
git clone https://github.com/dunedains/ecommers-pagos.git
git clone https://github.com/dunedains/ecommers-notifications.git

echo.
echo Construyendo imagen base (descarga dependencias una sola vez)...
docker build -t ecommers-base ./base

echo.
echo Listo. Ahora ejecuta: docker compose up --build
