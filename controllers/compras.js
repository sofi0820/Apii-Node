const compraModel = require('../models/compra');

const getCompras = async (req, res) => {
    try {
        const compras = await compraModel.getCompras();
        res.json(compras);
    } catch (error) {
        res.status(500).json({ message: 'Error al obtener las compras', error });
    }
};

const getCompraById = async (req, res) => {
    try {
        const idCompra = req.params.id;
        const compra = await compraModel.getComprasById(idCompra);
        if (compra) {
            res.json(compra);
        } else {
            res.status(404).json({ message: 'Compra no encontrada' });
        }
    } catch (error) {
        res.status(500).json({ message: 'Error al obtener la compra', error });
    }
};

const createCompra = async (req, res) => {
    try {
        const { numerocompra, fechacompra, descuento, iva, subtotal, total, idproveedor, estado } = req.body;
        const nuevaCompra = await compraModel.createCompra(numerocompra, fechacompra, descuento, iva, subtotal, total, idproveedor, estado);
        res.status(201).json({ id: nuevaCompra, message: 'Compra creada exitosamente' });
    } catch (error) {
        res.status(500).json({ message: 'Error al crear la compra', error });
    }
};

module.exports = { getCompras, getCompraById, createCompra };
