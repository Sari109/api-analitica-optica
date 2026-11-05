from decimal import Decimal

import pymysql


def obtener_conexion():
    return pymysql.connect(
        host = "localhost",
        user = "root",
        password = "",
        database = "optica",
        charset = "utf8mb4",
        cursorclass = pymysql.cursors.DictCursor,
    )


def ejecutar_consulta(sql, parametros=None):
    """Ejecuta un SELECT con SQL puro y devuelve una lista de diccionarios."""
    conexion = obtener_conexion()
    try:
        with conexion.cursor() as cursor:
            cursor.execute(sql, parametros)
            filas = cursor.fetchall()
    finally:
        conexion.close()

    # Los decimales de MySQL se pasan a número normal para que el JSON quede limpio
    for fila in filas:
        for campo, valor in fila.items():
            if isinstance(valor, Decimal):
                fila[campo] = float(valor)
    return filas