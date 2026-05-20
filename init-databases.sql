CREATE DATABASE db_productos;
CREATE DATABASE db_users;
CREATE DATABASE db_whitelist;
CREATE DATABASE db_reviews;
CREATE DATABASE db_inventory;
CREATE DATABASE db_cart;
CREATE DATABASE db_orders;
CREATE DATABASE db_pagos;
CREATE DATABASE db_notifications;

GRANT ALL PRIVILEGES ON DATABASE db_productos     TO ecommers;
GRANT ALL PRIVILEGES ON DATABASE db_users         TO ecommers;
GRANT ALL PRIVILEGES ON DATABASE db_whitelist     TO ecommers;
GRANT ALL PRIVILEGES ON DATABASE db_reviews       TO ecommers;
GRANT ALL PRIVILEGES ON DATABASE db_inventory     TO ecommers;
GRANT ALL PRIVILEGES ON DATABASE db_cart          TO ecommers;
GRANT ALL PRIVILEGES ON DATABASE db_orders        TO ecommers;
GRANT ALL PRIVILEGES ON DATABASE db_pagos         TO ecommers;
GRANT ALL PRIVILEGES ON DATABASE db_notifications TO ecommers;
