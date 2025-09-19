[server.js](https://github.com/user-attachments/files/22431053/server.js)
const express = require('express');
const app = express();
const PORT = 3000;

// Middleware para leer JSON
app.use(express.json());

// Usuarios en memoria (temporal, mientras no conectamos base de datos)
let usuarios = [];

// Ruta principal de prueba
app.get('/', (req, res) => {
  res.json({ mensaje: '¡Backend funcionando! 🚀' });
});

// Crear un usuario
app.post('/usuarios', (req, res) => {
  const { nombre, email } = req.body;

  if (!nombre || !email) {
    return res.status(400).json({ mensaje: 'Faltan datos' });
  }

  const nuevoUsuario = {
    id: usuarios.length + 1,
    nombre,
    email
  };

  usuarios.push(nuevoUsuario);

  res.status(201).json({ mensaje: 'Usuario creado', usuario: nuevoUsuario });
});

// Listar usuarios
app.get('/usuarios', (req, res) => {
  res.json(usuarios);
});

// Servidor escuchando
app.listen(PORT, () => {
  console.log(`Servidor corriendo en http://localhost:${PORT}`);
});
const Usuario = require('./Usuario');

// Registro
app.post('/registro', async (req, res) => {
    const { nombre, email, password } = req.body;

    const existe = await Usuario.findOne({ email });
    if (existe) return res.status(400).json({ mensaje: 'Email ya registrado' });

    const hashedPassword = await bcrypt.hash(password, 10);
    const usuario = new Usuario({ nombre, email, password: hashedPassword });
    await usuario.save();

    res.json({ mensaje: 'Usuario registrado', usuario: { id: usuario._id, nombre, email } });
});

// Login
app.post('/login', async (req, res) => {
    const { email, password } = req.body;
    const usuario = await Usuario.findOne({ email });
    if (!usuario) return res.status(400).json({ mensaje: 'Usuario no encontrado' });

    const valido = await bcrypt.compare(password, usuario.password);
    if (!valido) return res.status(400).json({ mensaje: 'Contraseña incorrecta' });

    const token = jwt.sign({ id: usuario._id, email: usuario.email }, 'mi_secreto', { expiresIn: '1h' });
    res.json({ mensaje: 'Login exitoso', token });
});



