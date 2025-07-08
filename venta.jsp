<%@ page import="Modelo.Producto, Dao.ProductoDao, Dao.VentaDao, Modelo.Venta, java.util.List, java.math.BigDecimal, java.sql.Connection, java.sql.PreparedStatement, java.sql.SQLException" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registrar Venta</title>
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.6.2/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
        
    <style>
            body {
        font-family: 'Montserrat', sans-serif;
        background-color: #f8f9fa;
    }
    .container {
        margin-top: 40px;
    }
    .form-container {
        background-color: #ffffff;
        padding: 40px;
        border-radius: 10px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }
    .form-container h2 {
        text-align: left;
        color: #5e72e4;
        margin-bottom: 30px;
        font-size: 52px;  /* Aumenta 2px el tamaño */
        font-weight: bold;  /* Poner en negrita */
        text-transform: uppercase;
        letter-spacing: 3px;
        text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2);
        margin-top: 20px;  /* Añadir separación superior */
    }
    .form-container label {
        font-weight: 600;
        color: #495057;
        font-size: 18px;  /* Aumentar el tamaño de la fuente */
    }
    .form-container input, .form-container select {
        border-radius: 5px;
        box-shadow: none;
        border: 1px solid #ced4da;
        font-size: 16px;  /* Aumentar el tamaño de la fuente */
    }
    .form-container .btn {
        border-radius: 5px;
        padding: 10px 20px;
        background-color: #5e72e4;
        color: #fff;
        border: none;
        font-size: 18px;  /* Aumentar el tamaño de la fuente */
    }
    .form-container .btn:hover {
        background-color: #4e62d7;
    }
    .table th, .table td {
        vertical-align: middle;
        font-size: 16px;  /* Aumentar el tamaño de la fuente */
    }
    .producto-row td {
        padding: 10px;
    }
    .form-group {
        margin-bottom: 30px;  /* Mayor separación entre los campos */
    }
    .form-group input, .form-group select {
        padding: 15px;
    }
    .form-group select {
        background-color: #f1f1f1;
    }
    .table-bordered {
        margin-top: 20px;
    }
    .form-control[readonly] {
        background-color: #f7f7f7;
    }
    .btn-secondary {
        background-color: #ff7b7b;
        border-color: #ff7b7b;
    }
    .btn-secondary:hover {
        background-color: #ff4f4f;
        border-color: #ff4f4f;
    }
    /* Espaciado adicional para separar el botón y el subtotal */
    .btn-secondary {
        margin-bottom: 30px; /* Aumenta el margen inferior del botón */
    }
    .form-group.subtotal {
        margin-top: 30px; /* Separa el subtotal del resto de los elementos */
    }

    /* Nueva clase para separar "Tipo Documento" de Boleta/Factura */
    .tipo-documento {
        margin-bottom: 20px; /* Añadir separación inferior */
    }       
    </style>
    
    <script>
        // Función para calcular subtotal y total dinámicamente
        function calcularSubtotal() {
            const precios = document.querySelectorAll('.precio');
            const cantidades = document.querySelectorAll('.cantidad');
            const subtotales = document.querySelectorAll('.subtotal');
            let subtotal = 0;

            precios.forEach((precio, index) => {
                const cantidad = cantidades[index].value || 0;
                const subtotalProducto = parseFloat(precio.value) * parseFloat(cantidad);
                subtotales[index].value = subtotalProducto.toFixed(2);
                subtotal += subtotalProducto;
            });

            // Calcular el total con IVA (18%)
            const total = subtotal * 1.18; // IVA 18%
            document.getElementById('subtotal').value = subtotal.toFixed(2);
            document.getElementById('total').value = total.toFixed(2); // Mostrar total con IVA
        }

        // Función para añadir una fila dinámica
        function agregarProducto() {
            const fila = document.querySelector('.producto-row').cloneNode(true);
            fila.querySelectorAll('input').forEach(input => input.value = '');
            document.querySelector('#productos').appendChild(fila);
        }

        // Función para actualizar el precio al seleccionar un producto
        function actualizarPrecio(selectElement) {
            const precio = selectElement.options[selectElement.selectedIndex].getAttribute('data-precio');
            const precioInput = selectElement.closest('tr').querySelector('.precio');
            precioInput.value = precio;
            calcularSubtotal();  // Recalcular subtotal cuando se cambia el precio
        }

        // Función para mostrar u ocultar campos según el tipo de documento seleccionado
        function mostrarCamposDocumento() {
            var tipoDocumento = document.querySelector('input[name="tipo_documento"]:checked').value;
            if (tipoDocumento === "boleta") {
                document.getElementById('dni').style.display = "block";
                document.getElementById('ruc').style.display = "none";
            } else if (tipoDocumento === "factura") {
                document.getElementById('dni').style.display = "none";
                document.getElementById('ruc').style.display = "block";
            }
        }

        // Llamar a la función al cargar la página para establecer el estado inicial
        window.onload = mostrarCamposDocumento;
    </script>
        <script>
        // Validar campos al escribir
        document.addEventListener('DOMContentLoaded', function() {
            const dniInput = document.getElementById('dni_cliente');
            const rucInput = document.getElementById('ruc_cliente');
            const telefonoInput = document.getElementById('telefono_cliente');
            const nombreInput = document.getElementById('nom_cliente');

            // Permitir solo números en campos de teléfono, DNI y RUC
            function validarSoloNumeros(event) {
                const charCode = event.which || event.keyCode;
                if (charCode < 48 || charCode > 57) { // Solo permitir dígitos (0-9)
                    event.preventDefault();
                    alert('Este campo solo acepta números.');
                }
            }

            // Permitir solo letras en el campo de nombre
            function validarSoloLetras(event) {
                const charCode = event.which || event.keyCode;
                const isLetter = (charCode >= 65 && charCode <= 90) || (charCode >= 97 && charCode <= 122);
                const isSpace = charCode === 32; // Espacio
                if (!isLetter && !isSpace) {
                    event.preventDefault();
                    alert('Este campo solo acepta letras.');
                }
            }

            // Asignar eventos a los campos
            dniInput.addEventListener('keypress', validarSoloNumeros);
            rucInput.addEventListener('keypress', validarSoloNumeros);
            telefonoInput.addEventListener('keypress', validarSoloNumeros);
            nombreInput.addEventListener('keypress', validarSoloLetras);
        });
        </script>
</head>
<body>
<div class="container mt-5">
    

    <div class="form-container">
            <a href="menu.jsp" class="home-icon" style="font-size: 50px;">
            <i class="fas fa-home"></i>
            </a>
        <h2>Registrar Venta</h2>
        <form action="venta.jsp" method="post">
            <input type="hidden" name="action" value="registrar">
            
            <div class="form-group">
                <label>Tipo de Documento:</label>
                <div>
                    <input type="radio" id="boleta" name="tipo_documento" value="boleta" onclick="mostrarCamposDocumento()" checked>
                    <label for="boleta">Boleta</label>
                    <input type="radio" id="factura" name="tipo_documento" value="factura" onclick="mostrarCamposDocumento()">
                    <label for="factura">Factura</label>
                </div>
            </div>

            <div class="form-group">
                <label for="nom_cliente">Nombre del Cliente:</label>
                <input type="text" class="form-control" name="nom_cliente" id="nom_cliente" required>
            </div>

            <!-- Campo DNI visible solo para Boleta -->
            <div class="form-group" id="dni">
                <label for="dni_cliente">DNI:</label>
                <input type="text" class="form-control" name="dni_cliente" id="dni_cliente">
            </div>

            <!-- Campo RUC visible solo para Factura -->
            <div class="form-group" id="ruc" style="display:none;">
                <label for="ruc_cliente">RUC:</label>
                <input type="text" class="form-control" name="ruc_cliente" id="ruc_cliente">
            </div>

            <div class="form-group">
                <label for="telefono_cliente">Teléfono:</label>
                <input type="text" class="form-control" name="telefono_cliente" id="telefono_cliente" required>
            </div>

            <div class="form-group">
                <label for="fecha">Fecha:</label>
                <input type="date" class="form-control" name="fecha" id="fecha" required>
            </div>

            <h4>Productos</h4>
            <table class="table table-bordered" id="productos">
                <thead>
                    <tr>
                        <th>Producto</th>
                        <th>Precio</th>
                        <th>Cantidad</th>
                        <th>Subtotal</th>
                    </tr>
                </thead>
                <tbody>
                    <tr class="producto-row">
                        <td>
                            <select class="form-control" name="producto[]" onchange="actualizarPrecio(this)">
                                <% 
                                    ProductoDao productoDao = new ProductoDao();
                                    List<Producto> productos = productoDao.listar();
                                    for (Producto producto : productos) {
                                %>
                                <option value="<%= producto.getCodProducto() %>" data-precio="<%= producto.getPrecio() %>">
                                    <%= producto.getNomProducto() %>
                                </option>
                                <% } %>
                            </select>
                        </td>
                        <td><input type="number" class="form-control precio" value="0" readonly></td>
                        <td><input type="number" class="form-control cantidad" value="0" oninput="calcularSubtotal()"></td>
                        <td><input type="number" class="form-control subtotal" value="0" readonly></td>
                    </tr>
                </tbody>
            </table>
            <button type="button" class="btn btn-secondary mb-3" onclick="agregarProducto()">Añadir Producto</button>

            <div class="form-group">
                <label for="subtotal">Subtotal:</label>
                <input type="number" class="form-control" name="subtotal" id="subtotal" readonly>
            </div>

            <div class="form-group">
                <label for="total">Total:</label>
                <input type="number" class="form-control" name="total" id="total" readonly>
            </div>

            <button type="submit" class="btn btn-primary">Registrar Venta</button>
        </form>
    </div> 
                            
                            
                            
    <%
        if ("registrar".equals(request.getParameter("action"))) {
            // Recoger los datos del formulario
            String nomCliente = request.getParameter("nom_cliente");
            String dniCliente = request.getParameter("dni_cliente");
            String telefonoCliente = request.getParameter("telefono_cliente");
            String fecha = request.getParameter("fecha");
            String rucCliente = request.getParameter("ruc_cliente");
            BigDecimal subtotal = new BigDecimal(request.getParameter("subtotal"));
            BigDecimal total = new BigDecimal(request.getParameter("total"));

            // Crear la instancia de Venta
            Venta venta = new Venta();
            venta.setNomCliente(nomCliente);
            if ("boleta".equals(request.getParameter("tipo_documento"))) {
                venta.setDni(dniCliente);
            } else {
                venta.setRuc(rucCliente);
            }
            venta.setTelefono(telefonoCliente);
            venta.setFecha(fecha);
            venta.setSubtotal(subtotal);
            venta.setTotal(total);

            // Insertar la venta en la base de datos
            try {
                VentaDao ventaDao = new VentaDao();
                ventaDao.registrarVenta(venta);
                out.println("<script>alert('Venta registrada exitosamente');</script>");
            } catch (SQLException e) {
                out.println("<script>alert('Error al registrar la venta');</script>");
            }
        }
    %>
</div>
<script>
    function mostrarBoleta() {
        // Recoger los datos de la venta
        var tipoDocumento = document.querySelector('input[name="tipo_documento"]:checked').value;
        var nombreCliente = document.getElementById("nom_cliente").value;
        var telefonoCliente = document.getElementById("telefono_cliente").value;
        var fecha = document.getElementById("fecha").value;
        var dniCliente = document.getElementById("dni_cliente").value;
        var rucCliente = document.getElementById("ruc_cliente").value;
        var subtotal = document.getElementById("subtotal").value;
        var total = document.getElementById("total").value;

        var productos = [];
        var productoElements = document.querySelectorAll('.producto-row');
        productoElements.forEach(function(row) {
            var producto = row.querySelector('select').options[row.querySelector('select').selectedIndex].text;
            var cantidad = row.querySelector('.cantidad').value;
            var precio = row.querySelector('.precio').value;
            var subtotalProducto = row.querySelector('.subtotal').value;
            productos.push({
                producto: producto,
                cantidad: cantidad,
                precio: precio,
                subtotal: subtotalProducto
            });
        });

        // Crear la ventana emergente con los detalles
        var boletaContenido = "<html><body style='font-family: Arial, sans-serif;'>" +
            // Agregar el logo y el nombre de la empresa
            "<div style='text-align: center; margin-bottom: 20px;'>" +
            "<img src='https://i.ibb.co/Npp0Kqg/40134485539b98518107073075d106e6-removebg-preview.png' alt='Logo Ferretería Don Emilio' style='width: 80px; height: auto;'>" +
            "<h2>Ferretería Don Emilio</h2>" +
            "</div>" +

            // Datos de la boleta
            "<h2>Comproabante de Venta</h2>" +
            "<p><strong>Tipo de Documento:</strong> " + tipoDocumento.charAt(0).toUpperCase() + tipoDocumento.slice(1) + "</p>" +
            "<p><strong>Nombre Cliente:</strong> " + nombreCliente + "</p>" +
            "<p><strong>Teléfono Cliente:</strong> " + telefonoCliente + "</p>" +
            "<p><strong>Fecha:</strong> " + fecha + "</p>";

        if (tipoDocumento === "boleta") {
            boletaContenido += "<p><strong>DNI:</strong> " + dniCliente + "</p>";
        } else {
            boletaContenido += "<p><strong>RUC:</strong> " + rucCliente + "</p>";
        }

        boletaContenido += "<h3>Productos:</h3><table border='1' style='width:100%; border-collapse: collapse;'>" +
            "<tr><th>Producto</th><th>Cantidad</th><th>Precio</th><th>Subtotal</th></tr>";

        productos.forEach(function(item) {
            boletaContenido += "<tr>" +
                "<td>" + item.producto + "</td>" +
                "<td>" + item.cantidad + "</td>" +
                "<td>" + item.precio + "</td>" +
                "<td>" + item.subtotal + "</td>" +
                "</tr>";
        });

        boletaContenido += "</table>" +
            "<p><strong>Subtotal:</strong> " + subtotal + "</p>" +
            "<p><strong>Total:</strong> " + total + "</p>" +
            "</body></html>";

        // Abrir la ventana emergente con la boleta
        var ventanaBoleta = window.open("", "Boleta", "width=600,height=400");
        ventanaBoleta.document.write(boletaContenido);
    }

    // Llamar a esta función después de enviar el formulario
    document.querySelector('form').addEventListener('submit', function(event) {
        event.preventDefault(); // Prevenir que el formulario se envíe de inmediato
        mostrarBoleta(); // Mostrar la boleta
        this.submit(); // Luego enviar el formulario
    });
</script>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.6.2/js/bootstrap.min.js"></script>
</body>
</html>