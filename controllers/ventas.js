const ventaModel = require('../models/venta');

const getVentas = async (req, res) => {
    try {
        const ventas = await ventaModel.getVentas();
        res.json(ventas);
    } catch (error) {
        res.status(500).json({ message: 'Error al obtener las ventas', error });
    }
};

const getVentaById = async (req, res) => {
    try {
        const idVenta = req.params.id;
        const venta = await ventaModel.getVentaById(idVenta);
        if (venta) {
            res.json(venta);
        } else {
            res.status(404).json({ message: 'Venta no encontrada' });
        }
    } catch (error) {
        res.status(500).json({ message: 'Error al obtener la venta', error });
    }
};

const createVenta = async (req, res) => {
    try {
        const { nombreCliente, fechaVenta, descuento, iva, subtotal, total, estado } = req.body;
        const nuevaVenta = await ventaModel.createVenta(nombreCliente, fechaVenta, descuento, iva, subtotal, total, estado);
        res.status(201).json({ id: nuevaVenta, message: 'Venta creada exitosamente' });
    } catch (error) {
        res.status(500).json({ message: 'Error al crear la venta', error });
    }
};

module.exports = { getVentas, getVentaById, createVenta };