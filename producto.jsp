<%@ page import="java.util.List" %>
<%@ page import="Modelo.Producto" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Productos</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: Arial, sans-serif;
        }
        .container {
            margin-top: 50px;
        }
        h2 {
            color: #343a40;
        }
        .table th, .table td {
            vertical-align: middle;
        }
        .btn {
            margin-right: 5px;
        }
    </style>

    <!-- Script para validación -->
    <script>
        function validarPrecio(event) {
            const charCode = event.which || event.keyCode;
            const inputValue = event.target.value;

            // Permitir teclas de retroceso (Backspace) y punto decimal
            if (charCode === 46 && inputValue.indexOf('.') === -1) {
                // Si ya tiene un punto, no permite otro
                return true;
            }

            // Permitir solo dígitos (0-9)
            if (charCode >= 48 && charCode <= 57) {
                return true;
            }

            // Si no es ni un número ni un punto, bloquear la entrada
            event.preventDefault();
            alert('Este campo solo acepta números y un punto decimal.');
        }
    </script>

</head>
<body>
<div class="container">
    <h2 class="text-center mb-4">Gestión de Productos</h2>

    <a href="menu.jsp" class="home-icon" style="font-size: 50px;">
        <i class="fas fa-home"></i>
    </a>
    
    <!-- Formulario para agregar un producto -->
    <div class="card mb-4 shadow-sm">
        <div class="card-header text-white bg-primary">
            Agregar Nuevo Producto
        </div>
        <div class="card-body">
            <form action="producto" method="post">
                <div class="mb-3">
                    <label for="nom_producto" class="form-label">Nombre del Producto</label>
                    <input type="text" class="form-control" name="nom_producto" placeholder="Ej. Martillo" required>
                </div>
                <div class="mb-3">
                    <label for="precio" class="form-label">Precio</label>
                    <input type="text" class="form-control" name="precio" placeholder="Ej. 25.50" required onkeypress="validarPrecio(event)">
                </div>
                <input type="hidden" name="action" value="agregar">
                <button type="submit" class="btn btn-success w-100">Agregar Producto</button>
            </form>
        </div>
    </div>

    <!-- Tabla de productos con la opción de editar -->
    <div class="card shadow-sm">
        <div class="card-header text-white bg-dark">
            Lista de Productos
        </div>
        <div class="card-body">
            <table class="table table-hover text-center">
                <thead class="table-dark">
                    <tr>
                        <th>Código</th>
                        <th>Nombre</th>
                        <th>Precio</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="producto" items="${productos}">
                        <tr>
                            <td>${producto.codProducto}</td>
                            <td>
                                <form action="producto" method="post" class="d-flex justify-content-center">
                                    <input type="hidden" name="cod_producto" value="${producto.codProducto}">
                                    <input type="text" class="form-control form-control-sm" name="nom_producto" 
                                           value="${producto.nomProducto}" required>
                            </td>
                            <td>
                                    <input type="text" class="form-control form-control-sm" name="precio" 
                                           value="${producto.precio}" required>
                            </td>
                            <td>
                                    <input type="hidden" name="action" value="editar">
                                    <button type="submit" class="btn btn-warning btn-sm">Editar</button>
                                </form>
                                <form action="producto" method="post" style="display:inline;">
                                    <input type="hidden" name="cod_producto" value="${producto.codProducto}">
                                    <input type="hidden" name="action" value="eliminar">
                                    <button type="submit" class="btn btn-danger btn-sm">Eliminar</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"></script>
</body>
</html>