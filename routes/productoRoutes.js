const { Router } = require('express');
const productoController = require('../controllers/productos');
const { check } = require('express-validator');
const { validarCampos } = require ('../middlewares/validar-campos');
const { existeIdIngresado } = require('../helpers/db-valitors');

const router = Router();
router.get('/', productoController.getProductos);
router.get('/:id', [
    check('id', 'No es un Id valido, por favor revise').isInt(),
    check('id', 'El Id ingresado no existe').custom(existeIdIngresado)
], productoController.getProductosById);
router.post('/', [
    check('nombre', 'El nombre no es valido').not().isEmpty(),
    check('cantidad','Verifica la cantidad').isInt(),
    check('precio', 'Verifica el precio ingresado').isDecimal(),
    validarCampos
], productoController.createProducto);
router.put('/:id',[
    check('id','El Id ingresado no es valido, verifique nuevamente').isInt(),
    check('id', 'El Id ingresado no exitse, por favor verifiquelo').custom(existeIdIngresado)
], productoController.editProducto);
router.delete('/:id', [
    check('id','El Id ingresado no es valido, verifique nuevamente').isInt(),
    check('id', 'El Id ingresado no exitse, por favor verifiquelo').custom(existeIdIngresado)
], productoController.deleteUsuario);
// router.delete('/:id', productoController.deleteProducto);
module.exports = router;