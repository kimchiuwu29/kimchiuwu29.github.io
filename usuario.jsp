<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Usuarios</title>
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
</head>
<body>
<div class="container">
    
    <a href="menu.jsp" class="home-icon" style="font-size: 50px;">
        <i class="fas fa-home"></i>
    </a>
    
    <h2 class="text-center mb-4">Gestión de Usuarios</h2>

    <!-- Formulario para agregar/editar un usuario -->
    <div class="card mb-4 shadow-sm">
        <div class="card-header text-white bg-primary">
            ${usuario != null ? "Editar Usuario" : "Agregar Nuevo Usuario"}
        </div>
        <div class="card-body">
            <form action="usuario" method="post">
                <input type="hidden" name="idUsuario" value="${usuario != null ? usuario.idUsuario : ''}">
                <div class="mb-3">
                    <label for="username" class="form-label">Usuario</label>
                    <input type="text" class="form-control" id="username" name="username" 
                           value="${usuario != null ? usuario.username : ''}" placeholder="Ingrese el nombre de usuario" required>
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label">Contraseña</label>
                    <input type="password" class="form-control" id="password" name="password" 
                           value="${usuario != null ? usuario.password : ''}" placeholder="Ingrese la contraseña" required>
                </div>
                <button type="submit" class="btn btn-success w-100">
                    ${usuario != null ? "Actualizar Usuario" : "Agregar Usuario"}
                </button>
            </form>
        </div>
    </div>

    <!-- Tabla de usuarios -->
    <div class="card shadow-sm">
        <div class="card-header text-white bg-dark">
            Lista de Usuarios
        </div>
        <div class="card-body">
            <table class="table table-hover text-center">
                <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Usuario</th>
                    <th>Contraseña</th>
                    <th>Acciones</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="u" items="${usuarios}">
                    <tr>
                        <td>${u.idUsuario}</td>
                        <td>
                            <form action="usuario" method="post" class="d-flex justify-content-center">
                                <input type="hidden" name="idUsuario" value="${u.idUsuario}">
                                <input type="text" class="form-control form-control-sm" name="username" 
                                       value="${u.username}" required>
                        </td>
                        <td>
                                <input type="password" class="form-control form-control-sm" name="password" 
                                       value="${u.password}" required>
                        </td>
                        <td>
                                <input type="hidden" name="action" value="editar">
                                <button type="submit" class="btn btn-warning btn-sm">Editar</button>
                            </form>
                            <form action="usuario" method="post" style="display:inline;">
                                <input type="hidden" name="idUsuario" value="${u.idUsuario}">
                                <input type="hidden" name="action" value="eliminar">
                                <button type="submit" class="btn btn-danger btn-sm"
                                        onclick="return confirm('¿Estás seguro de eliminar este usuario?');">Eliminar</button>
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