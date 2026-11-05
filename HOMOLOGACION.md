# HOMOLOGACIÓN – API REST de Analítica (Python + SQL nativo)

**Proyecto:** Sistema de gestión para óptica  
**Universidad de Córdoba – Base de Datos II**

## 1. Homologación de entidades

En mi proyecto de Sistema de gestión para óptica, identifiqué las entidades de acuerdo con los roles establecidos. La entidad Catálogo corresponde a **Categoría**, la entidad Ítem a **Producto**, la entidad Transaccional a **Venta y Detalle_Venta**, la entidad Actor a **Cliente y Usuario**, y la entidad de Contexto al **mes de la venta**.

| Rol | Entidad en mi proyecto | Explicación |
|---|---|---|
| Catálogo | Categoría | Se encarga de organizar los productos según su tipo, por ejemplo, monturas de acetato, lentes de contacto o estuches. |
| Ítem | Producto | Representa cada artículo que se ofrece en la óptica. Contiene información como el precio de venta y la cantidad disponible en inventario. |
| Transaccional | Venta y Detalle_Venta | Permite registrar cada venta, incluyendo su fecha, el total, los productos vendidos, sus cantidades y sus respectivos precios. |
| Actor | Cliente y Usuario | El cliente es quien realiza las compras y solicita las citas, aunque no tiene acceso directo al sistema. Por su parte, el usuario, que puede ser administrador u optometrista, es quien utiliza el sistema para gestionar las ventas y las citas. |
| Contexto | Mes de la venta | Se obtiene a partir del campo fecha de la tabla Venta. Como mi modelo de datos no contempla sedes ni ciudades, utilizo el mes como criterio para organizar y analizar las ventas. |

## 2. ¿Qué responde cada endpoint?

**Endpoint 1: GET /api/reportes/clasificacion-top**

Este endpoint muestra las categorías cuyos productos tienen un promedio de venta superior al promedio general de la óptica. Para obtener este resultado, agrupo las ventas por categoría, calculo el promedio del valor de los productos vendidos y comparo ese resultado con el promedio general del sistema. Para realizarlo utilizo `GROUP BY` y una subconsulta escalar dentro del `HAVING`, que me permite filtrar únicamente las categorías que cumplen esa condición.

**Endpoint 2: GET /api/analitica/actores-estrella**

Este endpoint permite identificar a los clientes que más compran en la óptica, específicamente aquellos cuyo gasto total supera el promedio de lo que gastan los demás clientes. Primero agrupo las compras por cliente y calculo cuánto ha gastado cada uno. Después, utilizo una subconsulta sobre una tabla derivada para obtener el promedio de esos totales y compararlo con el gasto de cada cliente mediante `HAVING`.

**Endpoint 3: GET /api/items/desviacion-grupo**

Este endpoint identifica los productos cuyas ventas están por debajo del promedio de los productos de su misma categoría. La comparación se realiza dentro de cada grupo, por lo que un producto no se compara con todos los artículos de la óptica, sino únicamente con los que pertenecen a su categoría. Para esto utilizo `GROUP BY` por producto y una subconsulta correlacionada dentro del `HAVING`.

**Endpoint 4: GET /api/segmentos/analisis-limpio**

Este endpoint muestra el total de ventas realizadas en cada mes, excluyendo las compras de los clientes que tienen al menos una cita cancelada, ya que los considero casos importantes para este análisis. Para obtener los resultados, agrupo las ventas por mes y utilizo `NOT IN` dentro del `WHERE` para excluir a esos clientes antes de realizar la agrupación.

**Endpoint 5: GET /api/operaciones/resumen-dinamico?min_operaciones=N**

Este endpoint agrupa las ventas por usuario y muestra únicamente aquellos que cumplen dos condiciones: haber realizado como mínimo N ventas y tener un promedio de venta superior al precio del producto más económico del catálogo.

El valor de N se recibe directamente desde la URL mediante el parámetro `min_operaciones`. Si no se proporciona, el sistema utiliza 2 como valor predeterminado. Para implementar esta consulta utilizo el parámetro `%s` dentro del `HAVING` y una subconsulta con `MIN` sobre la tabla Producto, que permite obtener el precio mínimo del catálogo.

## 3. Códigos de respuesta

La API responde 200 cuando hay datos, 404 cuando la consulta no encuentra nada, 400 si en el endpoint 5 el valor de min_operaciones no es un número entero positivo, y 500 si ocurre un error interno.