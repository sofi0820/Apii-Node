const usuarioModel = require('../models/usuario');
const proveedorModel = require('../models/proveedor');
const compraModel = require('../models/compra');
const rolesValidos = ['Administrador', 'Usuario'];

const RolValido = (role) => {
    if (!rolesValidos.includes(role)) {
        throw new Error('El rol no es válido');
    }
    return true;
};
const existeEmailIngresado = async (correo) => {
    const existeEmail = await usuarioModel.correo.firstOne({ correo});
    if (existeEmail) {
        throw new Error('Ese correo ya existe');
    }
    return true;
};
const existeIdIngresado = async (idUsuario) =>{
    const existeId = await usuarioModel.id.firstOne({idUsuario});
    if (!existeId) {
        throw new Error('Ese correo ya existe');
    }
    return true;
};
const existeTelefono = async(telefono) => {
    const existeTel = await proveedorModel.telefono(telefono); 
    if (existeTel.length > 0) {
        throw new Error('El teléfono ya está registrado, verifique los datos ingresados');
    }
    return true;
}
const existeNumeroCompra = async (numerocompra) =>  {
    const existeCompra = await compraModel.numeroCompra(numerocompra);
    if (existeCompra.length > 0) {
        throw new Error('El numero de compra ya está registrado, verifique los datos ingresados');
    }
    return true;
}
module.exports = {RolValido, existeEmailIngresado, existeIdIngresado, existeTelefono, existeNumeroCompra }