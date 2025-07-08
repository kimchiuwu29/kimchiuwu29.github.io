<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Menú Principal</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <!-- Agregar Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@700&family=Roboto+Slab:wght@500&display=swap" rel="stylesheet">

    <style>
        body {
            background-color: #f4f1e1; /* Color de fondo cálido */
            font-family: 'Arial', sans-serif;
        }

        .container {
            margin-top: 50px;
        }

        .header {
            text-align: center;
            font-size: 50px;
            font-weight: bold;
            color: #6a4e23; /* Color amaderado */
            margin-bottom: 40px;
        }

        .header img {
            width: 300px; /* Tamaño del logo ajustado a 300px */
            height: auto;
            margin-top: 10px;
        }

        /* Estilos para las gestiones */
        .menu-item {
            background-color: #8e6e4e; /* Gama amaderada */
            color: #fff;
            height: 200px;
            text-align: center;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.2);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .menu-item:hover {
            transform: translateY(-10px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.3);
        }

        .menu-item a {
            display: block;
            color: #fff;
            text-decoration: none;
            font-size: 26px; /* Tamaño de fuente aumentado */
            font-weight: bold;
            text-transform: uppercase; /* Letras en mayúsculas */
            letter-spacing: 2px; /* Espaciado entre letras */
            font-family: 'Roboto Slab', serif; /* Fuente más elegante */
            transition: color 0.3s ease;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2); /* Sombra para darle estilo */
        }

        .menu-item a:hover {
            color: #f8f9fa;
            text-decoration: underline;
        }

        .col-md-4 {
            margin-bottom: 30px;
        }

        /* Estilo del botón cerrar sesión */
        .logout-btn {
            position: absolute;
            top: 20px;
            right: 20px;
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
        }

        .logout-btn:hover {
            background-color: #c82333;
        }

        /* Estilo del mensaje de sesión cerrada */
        #mensajeSesion {
            display: none;
            position: fixed;
            top: 10%;
            right: 10%;
            z-index: 1050;
            background-color: #28a745;
            color: white;
            padding: 10px 20px;
            border-radius: 5px;
            font-size: 16px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>
    <div class="container text-center">
        <!-- Título de la tienda con ilustración -->
        <div class="header">
            Ferretería Don Emilio
            <br>
            <img src="https://i.ibb.co/Npp0Kqg/40134485539b98518107073075d106e6-removebg-preview.png" alt="Ilustración de Ferretería">
        </div>

        <!-- Botón de Cerrar sesión -->
        <button class="logout-btn" onclick="cerrarSesion()">Cerrar sesión</button>

        <!-- Menú de opciones -->
        <div class="row">
            <div class="col-md-4">
                <div class="menu-item">
                    <a href="producto.jsp">Gestión de Productos</a>
                </div>
            </div>
            <div class="col-md-4">
                <div class="menu-item">
                    <a href="venta.jsp">Gestión de Ventas</a>
                </div>
            </div>
            <div class="col-md-4">
                <div class="menu-item">
                    <a href="usuario.jsp">Gestión de Usuarios</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Mensaje de sesión cerrada -->
    <div id="mensajeSesion">
        Su sesión se ha cerrado correctamente.
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script>
        function cerrarSesion() {
            // Simular cierre de sesión y mostrar el mensaje
            // Puedes usar AJAX aquí si deseas realizar la invalidación del servidor sin recargar la página
            document.getElementById('mensajeSesion').style.display = 'block';

            // Redirigir a index.jsp después de un tiempo
            setTimeout(function() {
                window.location.href = 'index.jsp'; // Redirigir a la página de inicio
            }, 3000); // Espera 3 segundos antes de redirigir
        }
    </script>
</body>
</html>