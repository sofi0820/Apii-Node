const usuarioModel = require('../models/usuario')
const bcryptjs = require('bcryptjs')

const getUsuarios = async (req, res) => {
    try {
        const { limit, offset } = req.query;
        const limite = parseInt(limit) || 10; 
        const off = parseInt(offset) || 0;

        // Obtener usuarios y el conteo total de usuarios con estado 1
        const [total, usuarios] = await Promise.all([
            usuarioModel.countUsuarios(),
            usuarioModel.usuariosLimit(limite, off)  
        ]);
        const usuariosPersonalizados = usuarios.map(usuario => {
            return {
                uid: usuario.idUsuario,
                nombre: usuario.nombre,
                correo: usuario.correo,
                rol: usuario.rol,
                estado: usuario.estado,
                google: usuario.google
            };
        });

        res.json({ total, usuarios: usuariosPersonalizados });
    } catch (error) {
        res.status(500).json({ message: 'Error al obtener los usuarios', error });
    }
};
const getUsuarioById = async (req, res) => {
    try {
        const idUsuario = req.params.id;
        const usuario = await usuarioModel.getUsuarioById(idUsuario); 
        if (usuario) {
            res.json(usuario);
        } else {
            res.status(404).json({ message: 'Usuario no encontrado' });
        }
    } catch (error) {
        res.status(500).json({ message: 'Error al obtener usuario', error });
    }
};
const createUsuario = async (req, res) => {
    try {
        const { nombre, correo, contrasena, img, rol } = req.body;
        const estado = 'Activo';
        const google = 'false';

        
        // Encriptación de la contraseña
        const salt = bcryptjs.genSaltSync();
        const contrasenaEncriptada = bcryptjs.hashSync(contrasena, salt);

        const nuevoUsuarioId = await usuarioModel.createUsuario(nombre, correo, contrasenaEncriptada, img, rol, estado, google);
        res.status(201).json({ id: nuevoUsuarioId, message: 'Usuario creado exitosamente' });
    } catch (error) {
        res.status(500).json({ message: 'Error al crear usuario', error });
    }
};
const editUsuario = async (req, res) => {
    try {
        const idUsuario = req.params.id;
        const { nombre, correo, contrasena, img, rol, estado } = req.body;

        // Encriptación de la contraseña
        const salt = bcryptjs.genSaltSync();
        const contrasenaEncriptada = bcryptjs.hashSync(contrasena, salt);

        const rowsAffected = await usuarioModel.actualizarUsuario(idUsuario, nombre, correo, contrasenaEncriptada, img, rol, estado);

        if (rowsAffected === 0) {
            return res.status(404).json({ message: 'Usuario no encontrado' });
        }
        res.status(200).json({ message: 'Usuario actualizado exitosamente' });
    } catch (error) {
        res.status(500).json({ message: 'Error al actualizar usuario', error: error.message });
    }
};
const deleteUsuario = async (req, res) => {
    const { id } = req.params;
    const estado = 'Inactivo'; 

    try {
        const usuarioInfo = await usuarioModel.getUsuarioById(id);
        if (!usuarioInfo) {
            return res.status(404).json({ msg: 'Usuario no encontrado' });
        }
        await usuarioModel.deleteUsuario(id, estado);
        const usuarioAutenticado = req.uid;  
        res.json({ 
            msg: 'Usuario inactivado correctamente',
            usuario: {
                ...usuarioInfo,
                estado: 'Inactivo'
            },
            usuarioAutenticado  
        });
    } catch (error) {
        console.error(error);
        res.status(500).json({
            msg: 'Error al inactivar el usuario'
        });
    }
};




//Cambio de limit
/* const getUsuarios = async (req, res) => {
    try {
        // Obtener los parámetros de consulta de la URL
        const { limit, offset } = req.query;
        
        // Convertir los valores de limit y offset a números enteros
        const limitValue = parseInt(limit) || 10; // Establecer un valor predeterminado si limit no se proporciona
        const offsetValue = parseInt(offset) || 0; // Establecer un valor predeterminado si offset no se proporciona

        // Obtener los usuarios según el límite y el desplazamiento
        const usuarios = await usuarioModel.getUsuariosLimitOffset(limitValue, offsetValue);
        
        res.json(usuarios);
    } catch (error) {
        res.status(500).json({ message: 'Error al obtener los usuarios', error });
    }
 }; */

module.exports = { getUsuarios, getUsuarioById, createUsuario, editUsuario, deleteUsuario}
