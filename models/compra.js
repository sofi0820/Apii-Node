const pool = require('../config/database');

const getCompras = async () => {
    const [rows] = await pool.query('SELECT * FROM compras');
    return rows;
};

const getComprasById = async (id) => {
    const [rows] = await pool.query('SELECT * FROM compras WHERE id = ?', [id]);
    return rows[0];
};

const createCompra = async (numerocompra, fechacompra, descuento, iva, subtotal, total, idproveedor, estado) => {
    const [result] = await pool.query(
        'INSERT INTO compras (numerocompra, fechacompra, descuento, iva, subtotal, total, idproveedor, estado) VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
        [numerocompra, fechacompra, descuento, iva, subtotal, total, idproveedor, estado]
    );
    return result.insertId;
};

//Metodos adicionales
const numeroCompra = async (numerocompra) => {
    const [rows] = await pool.query('SELECT * FROM compras WHERE numerocompra = ?', [numerocompra]);
    return rows;
};
module.exports = { getCompras, getComprasById, createCompra, numeroCompra };
