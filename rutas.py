from flask import Blueprint, jsonify, request

from db import ejecutar_consulta

rutas = Blueprint("rutas", __name__)


def responder(sql, parametros=None):
    """Ejecuta la consulta y responde con 200, 404 o 500."""
    try:
        filas = ejecutar_consulta(sql, parametros)
        if not filas:
            return jsonify({"mensaje": "No se encontraron resultados"}), 404
        return jsonify(filas), 200
    except Exception as error:
        print("Error en la consulta:", error)
        return jsonify({"error": "Error interno del servidor"}), 500


@rutas.route("/api/reportes/clasificacion-top", methods=["GET"])
def clasificacion_top():
    return responder("""
        SELECT c.nombre AS categoria,
               SUM(dv.cantidad * dv.precio_vendido) AS total_recaudado,
               ROUND(AVG(dv.cantidad * dv.precio_vendido), 2) AS promedio_por_operacion
        FROM categoria c
        JOIN producto p ON p.id_categoria = c.id_categoria
        JOIN detalle_venta dv ON dv.id_producto = p.id_producto
        GROUP BY c.id_categoria, c.nombre
        HAVING AVG(dv.cantidad * dv.precio_vendido) > (
            SELECT AVG(cantidad * precio_vendido)
            FROM detalle_venta
        )
    """)


@rutas.route("/api/analitica/actores-estrella", methods=["GET"])
def actores_estrella():
    return responder("""
        SELECT c.id_cliente,
               CONCAT(c.nombre, ' ', c.apellido) AS cliente,
               SUM(v.total) AS total_gastado
        FROM cliente c
        JOIN venta v ON v.id_cliente = c.id_cliente
        GROUP BY c.id_cliente, c.nombre, c.apellido
        HAVING SUM(v.total) > (
            SELECT AVG(t.total_cliente)
            FROM (
                SELECT SUM(total) AS total_cliente
                FROM venta
                GROUP BY id_cliente
            ) AS t
        )
    """)
    

@rutas.route("/api/items/desviacion-grupo", methods=["GET"])
def desviacion_grupo():
    return responder("""
        SELECT p.id_producto,
               p.nombre AS producto,
               c.nombre AS categoria,
               CAST(COALESCE(SUM(dv.cantidad), 0) AS SIGNED) AS unidades_vendidas
        FROM producto p
        JOIN categoria c ON c.id_categoria = p.id_categoria
        LEFT JOIN detalle_venta dv ON dv.id_producto = p.id_producto
        GROUP BY p.id_producto, p.nombre, p.id_categoria, c.nombre
        HAVING COALESCE(SUM(dv.cantidad), 0) < (
            SELECT COALESCE(SUM(dv2.cantidad), 0) / COUNT(DISTINCT p2.id_producto)
            FROM producto p2
            LEFT JOIN detalle_venta dv2 ON dv2.id_producto = p2.id_producto
            WHERE p2.id_categoria = p.id_categoria
        )
    """)


@rutas.route("/api/segmentos/analisis-limpio", methods=["GET"])
def analisis_limpio():
    return responder("""
        SELECT MONTH(v.fecha) AS mes,
               COUNT(*) AS num_ventas,
               SUM(v.total) AS total_vendido
        FROM venta v
        WHERE v.id_cliente NOT IN (
            SELECT id_cliente
            FROM cita
            WHERE estado = 'Cancelada'
        )
        GROUP BY MONTH(v.fecha)
        ORDER BY mes
    """)
    

@rutas.route("/api/operaciones/resumen-dinamico", methods=["GET"])
def resumen_dinamico():
    valor = request.args.get("min_operaciones", "2")
    if not valor.isdigit():
        return jsonify({"error": "min_operaciones debe ser un número entero positivo"}), 400
    min_operaciones = int(valor)

    return responder("""
        SELECT u.id_usuario,
               u.nombre AS usuario,
               COUNT(v.id_venta) AS num_ventas,
               ROUND(AVG(v.total), 2) AS promedio_por_venta
        FROM venta v
        JOIN usuario u ON u.id_usuario = v.id_usuario
        GROUP BY u.id_usuario, u.nombre
        HAVING COUNT(v.id_venta) >= %s
           AND AVG(v.total) > (
               SELECT MIN(precio_venta)
               FROM producto
           )
    """, (min_operaciones,))