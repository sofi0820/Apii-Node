const jwt = require('jsonwebtoken');
const usuarioModel = require('../models/usuario');
const { response } = require('express');

const validarJwt = async (req, res = response, next) => {
    const token = req.header('x-token');

    if (!token) {
        return res.status(401).json({ message: 'No existe un token en la solicitud' });
    }

    try {
        const payload = jwt.verify(token, process.env.SECRETORPRIVATEKEY);
        console.log(payload);
        req.uid = payload.uid;
        next();
    } catch (error) {
        console.log('Error al verificar el token:', error);
        res.status(401).json({ message: 'Token no válido' });
    }
};


module.exports = { validarJwt }