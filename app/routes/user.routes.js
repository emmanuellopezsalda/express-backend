import { Router } from "express";
import { deleteUser, getUsers, login, postUser, updateUser } from "../controllers/user.controller.js";

const routesUser = Router();

routesUser.get("/", getUsers);
routesUser.post("/", postUser);
routesUser.put("/:id", updateUser);
routesUser.delete("/:id", deleteUser);
routesUser.post("/login", login);

export default routesUser