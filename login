<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <title>Login - San Martín App</title>
    <link rel="stylesheet" href="style.css">
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f4faff;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .login-card {
            background: white;
            padding: 2rem;
            border-radius: 12px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            max-width: 400px;
            width: 100%;
            text-align: center;
        }

        .login-card h2 {
            margin-bottom: 1rem;
            color: #00aaff;
        }

        .login-card input {
            width: 100%;
            padding: 0.8rem;
            margin: 0.5rem 0;
            border: 1px solid #ccc;
            border-radius: 8px;
        }

        .login-card button {
            width: 100%;
            padding: 0.8rem;
            background: #00aaff;
            border: none;
            border-radius: 8px;
            color: white;
            font-weight: bold;
            cursor: pointer;
            margin-top: 1rem;
        }

        .login-card button:hover {
            background: #0088cc;
        }

        #mensajeLogin {
            margin-top: 1rem;
            font-size: 0.9rem;
        }
    </style>
</head>

<body>
    <div class="login-card">
        <h2>Iniciar Sesión</h2>
        <input type="email" id="emailLogin" placeholder="Email" required>
        <input type="password" id="passwordLogin" placeholder="Contraseña" required>
        <button onclick="loginUsuario()">Ingresar</button>
        <p id="mensajeLogin"></p>
    </div>

    <script>
        async function loginUsuario() {
            const email = document.getElementById('emailLogin').value;
            const password = document.getElementById('passwordLogin').value;
            const mensaje = document.getElementById('mensajeLogin');

            try {
                const response = await fetch("http://localhost:3000/login", {
                    method: "POST",
                    headers: { "Content-Type": "application/json" },
                    body: JSON.stringify({ email, password })
                });

                const data = await response.json();

                if (response.ok) {
                    mensaje.style.color = "green";
                    mensaje.textContent = "Login exitoso. Bienvenido " + data.nombre;
                    // 👉 Podés redirigir a otra página
                    // window.location.href = "index.html";
                } else {
                    mensaje.style.color = "red";
                    mensaje.textContent = data.mensaje || "Error en login";
                }
            } catch (error) {
                mensaje.style.color = "red";
                mensaje.textContent = "Error al conectar con el servidor";
                console.error(error);
            }
        }
    </script>
</body>






</html>
