---
runme:
  id: 01HNV3RPVH7C1960ZC2T7XECQS
  version: v2.2
---

# XML Validator
Este servicio recibe una petición **POST** con Express el cual permite recibir un archivo XML de una factura.
La solicitud se utiliza para extraer información básica de la factura.
La información extraída se devolvuelve en un .JSON una estructura como este ejemplo:
```
{
  total: '23780',
  uuid: '234b99e8-a2f5-4034-b8b5-192ad7ae5b64',
  fecha_timbrado: '2023-12-10T19:55:20',
  emisor: {
    rfc: 'EKU9003173C9',
    nombre: 'ESCUELA KEMPER URGATE',
    regimen_fiscal: '601'
  },
  receptor: {
    rfc: 'CACX7605101P8',
    nombre: 'XOCHILT CASAS CHAVEZ',
    regimen_fiscal: 'G03'
  }
}
```

- Antes de probar este proyecto es necesario considerar tener instalado [NodeJS](https://nodejs.org/en/blog/release/v20.9.0)
- En la versión local en donde se desarrolló fue en la versión `v20.9.0`

Si ya cuentas con algúna version de NodeJS instalada puedes validar la versión con el siguiente comando en la consola: `node -v`

## Instalación
- Instala el repositorio en tu computadora en el directorio de tu elección con el siguiente comando:

```
git clone https://github.com/carlos-ssh/redesigned-octo-couscous.git
```

- Ingresa al directorio del proyecto instalado:

```
cd redesigned-octo-couscous
```

- Una vez dentro del directorio del proyecto corre la instalación de las dependencias necesarias para el funcionamiento con el siguiente comando:

```
npm install
```

## Funcionalidad
Para activar el servicio usa:

```
npm run dev
```

Para usar el archivo XML de prueba puedes encontrarlo en el directorio `./public/files` del proyecto, el nombre del archivo es: `factura_prueba.xml`

- Para dar uso a este comando de ejemplo es necesario tener instalado [CURL](https://curl.se/download.html)
- En el comando hace una petición POST a `http://localhost:3000/api/xml-reader`
- Agrega un archivo desde el directorio publico `public/files/factura_prueba.xml`

Puedes copiar y pegar el siguiente comando:

```
curl -X POST -F "xml=@public/files/factura_prueba.xml" http://localhost:3000/api/xml-reader
```

Hay un `console.log` en donde te muestra el 'Objeto JSON' de salida. Así mismo envía una respuesta en el mismo formato
Ejemplo:

```
{
  total: '23780',
  uuid: '234b99e8-a2f5-4034-b8b5-192ad7ae5b64',
  fecha_timbrado: '2023-12-10T19:55:20',
  emisor: {
    rfc: 'EKU9003173C9',
    nombre: 'ESCUELA KEMPER URGATE',
    regimen_fiscal: '601'
  },
  receptor: {
    rfc: 'CACX7605101P8',
    nombre: 'XOCHILT CASAS CHAVEZ',
    regimen_fiscal: 'G03'
  }
}
```

Si tienes algún problema puedes [Crear un Issue](https://github.com/carlos-ssh/redesigned-octo-couscous/issues)

# SQL Queries
En el directorio del proyecto vas a encontrar un directorio en donde se encuentran las consultas creadas para las caracteristicas
requeridas para el proyecto.

## Creación y población de las tablas
Para tener instaladas las tablas correspondientes ingresa a MySQL desde la consola con el siguiente comando:

```
➜  ~ mysql -u root -p
```
Una vez dentro corre cada creación de las tablas para el proyecto en donde vas a encontrar los archivos en este directorio:

```
sql/queries/createDB.sql
```

En el mismo archivo encontrarás los `INSERT` para popular las tablas

## Creación de Vistas y su uso
Para crear una vista y poder conocer el producto mas vendido por sucursal en cada mes por año
Copia el código del archivo: `bestSellingProduct.sql` y pegalo en la consola con MySQL corriendo.

Una vez creada recibirás un mensaje como el siguiente ejemplo: `Query OK, 0 rows affected, 0 warning (0.01 sec)`

### Para usar la Vista
Si la creación de la vista fue correacta como el mensaje de confirmación descrito anteriormente
Usa el siguiente comando para mostrar la información:

```
SELECT * FROM MostSellingProductByBranch;
```

Vas a recibír la siguiente información en pantalla:

```
+-----------+-------------+------+-------+------------+--------------+------------------+
| branch_id | branch_name | year | month | product_id | product_name | cantidad_vendida |
+-----------+-------------+------+-------+------------+--------------+------------------+
|         1 | Downtown    | 2024 |     2 |          1 | Laptop       |                1 |
|         2 | Suburb      | 2024 |     2 |          2 | Jeans        |                1 |
|         1 | Downtown    | 2024 |     2 |          4 | Novel        |                1 |
+-----------+-------------+------+-------+------------+--------------+------------------+
```

## Procedimiento según el id de sucursal
Para crear el procedimiento es necesario copiar y pegar el código del archivo: `SummaryOfPurchasesByBranch.sql`
Una vez aceptado el código en la consola vas a recibir el siguiente mensaje: `Query OK, 0 rows affected (0.04 sec)`

### Uso del Procedimiento
Para dar uso al procedimiento necesitas el siguiente comando:

```
CALL SummaryOfPurchasesByBranch(1);
```

Esto te va a dar una salida como este ejemplo:

```
CALL SummaryOfPurchasesByBranch(2);
+----------+-----+---------------------+-----------------+--------------+--------------------+-----------------+---------------------+
| name     | age | email               | compras_pagadas | total_pagado | compras_canceladas | total_cancelado | excelente_comprador |
+----------+-----+---------------------+-----------------+--------------+--------------------+-----------------+---------------------+
| Jane Doe |  25 | janedoe@example.com |               1 |           40 |                  1 |              25 | No                  |
+----------+-----+---------------------+-----------------+--------------+--------------------+-----------------+---------------------+
1 row in set (0.00 sec)
```

## Mostrar las 5 categorías menos vendidas en una sucursal
Para poder realizar este paso, es necesario contar con el `id` de sucursal y las tablas relacionadas llenas con información.

Copia y pega el código del archivo: `FiveLeastSoldCategories.sql`
Este código debe de ser aceptado (Si no existen registros vas a ver una salida como la siguiente: `Empty set (0.01 sec)`)

O bien si tus tablas cuentan con la información y el ID 375 vas a tener esta salida siguiente:

```
SELECT cat.name AS categoria_nombre, COUNT(pp.product_id) AS cantidad_vendida, SUM(pr.price) AS total_ventas
    ->     FROM purchase_product pp
    ->     JOIN purchase p ON pp.purchase_id = p.id
    ->     JOIN product pr ON pp.product_id = pr.id
    ->     JOIN category cat ON pr.category_id = cat.id
    ->     JOIN customer c ON p.customer_id = c.id
    ->     WHERE c.branch_id = 375 AND p.status = 'pagado'
    ->     GROUP BY cat.id
    ->     ORDER BY total_ventas ASC
    ->     LIMIT 5;
+------------------+------------------+--------------+
| categoria_nombre | cantidad_vendida | total_ventas |
+------------------+------------------+--------------+
| Books            |                1 |           15 |
| Clothing         |                1 |           25 |
| Home Appliances  |                1 |          100 |
| Juguetes         |                1 |         1500 |
+------------------+------------------+--------------+
4 rows in set (0.00 sec)
```

## Autor
[Carlos Flores](https://github.com/carlos-ssh/)
[LinkedIn](https://www.linkedin.com/in/carlos-ssh/)

## Licencia MIT
