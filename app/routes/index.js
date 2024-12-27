import { Router } from "express";
import routesUser from "./user.routes.js";
import routesShipments from "./shipment.routes.js";

const routes = Router();

routes.use("/users", routesUser);
routes.use("/shipments", routesShipments);

export default routes;