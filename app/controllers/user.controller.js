import { db } from "../config/db.config.js";
import { error, success } from "../messages/message.js";

export const getUsers = async(req, res) => {
    try {
        const [users] = await db.query("CALL SP_GET_USER");
        success(req, res, 200, "", users[0]);        
    } catch (err) {
        error(req, res, 500, err.message);
    }
}

export const postUser = async(req, res) => {
    const {username, email, address, document, cellphone, password} = req.body;
    try {
        const result = await db.query("CALL SP_POST_USER(?,?,?,?,?,?)", [username, email, address, document, cellphone, password]);
        success(req, res, 200, "Usuario creado");
    } catch (err) {
        error(req, res, 500, err.message);
    }
}

export const updateUser = async(req, res) => {
    const {id} = req.params;
    const {username, email, address, document, cellphone, password} = req.body;
    try {
        const result = await db.query("CALL SP_UPDATE_USER(?,?,?,?,?,?,?)", [id, username, email, address, document, cellphone, password]);
        success(req, res, 201, "Usuario Actualizado");
    } catch (err) {
        error(req, res, 500, err.message);
    }
}

export const deleteUser = async(req, res) => {
    const {id} = req.params;
    try {
        const result = await db.query("CALL SP_DELETE_USER(?)", [id]);
        success(req, res, 200, "Usuario Eliminado");
    } catch (err) {
        error(req, res, 404, err.message);
    }
}

export const login = async (req, res) => {
    const {username, password} = req.body;
    try {
        const result = await db.query("CALL SP_LOGIN_USER(?, ?)", [username, password]);
        const user = result[0][0][0]; 

        if (!user || user.user_id === 0) {
            return error(req, res, 401, "Usuario o contraseña incorrecto");
        }
        success(req, res, 200, "Inicio de Sesión exitoso", { user_id: user.user_id });
    } catch (err) {
        console.error(err);
        error(req, res, 500, "Error en el servidor");
    }
};
