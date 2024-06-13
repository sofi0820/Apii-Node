const pool = require('../config/database');

const getVentas = async () => {
    const [rows] = await pool.query('SELECT *  FROM ventas');
    return rows;
};

const getVentaById = async (id) => {
    const [rows] = await pool.query('SELECT * FROM ventas WHERE idVenta = ?', [id]);
    return rows[0];
};

const createVenta = async (nombreCliente, fechaVenta, descuento, iva, subtotal, total,estado) => {
    const [result] = await pool.query(
        'INSERT INTO ventas (nombreCliente, fechaVenta, descuento, iva, subtotal, total, estado) VALUES (?, ?, ?, ?, ?, ?, ?)',
        [nombreCliente, fechaVenta, descuento, iva, subtotal, total, estado]
    );
    return result.insertId;
};

//Metodos adicionales
// const numeroCompra = async (numerocompra) => {
//     const [rows] = await pool.query('SELECT * FROM compras WHERE numerocompra = ?', [numerocompra]);
//     return rows;
// };
module.exports = { getVentas, getVentaById, createVenta };
