import { db } from "../config/db.config.js";
import { error, success } from "../messages/message.js";

export const getAllShipments = async(req, res) => {
    try {
        const shipments = await db.query("CALL SP_GET_SHIPMENTS");
        success(req, res, 200, "", shipments[0][0]);
    } catch (err) {
        error(req, res, 500, err.message);
    }
}
export const postShipment = async(req, res) => {
    const {id_user, shipment_date, city_a, city_b, weight, broad, large, height, commercial_value} = req.body;    
    try {
        const result = await db.query("CALL SP_POST_SHIPMENT(?,?,?,?,?,?,?,?,?)", [id_user, shipment_date, city_a, city_b, weight, broad, large, height, commercial_value]);
        success(req, res, 200, "Envío creado");
    } catch (err) {
        error(req, res, 500, err);
    }
}