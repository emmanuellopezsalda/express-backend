import { Router } from "express";
import { getAllShipments, postShipment } from "../controllers/shipment.controller.js";

const routesShipments = Router();

routesShipments.get("/", getAllShipments);
routesShipments.post("/", postShipment);

export default routesShipments