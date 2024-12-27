import { config } from "dotenv";
import express from "express";
import routes from "./routes/index.js";
import cors from "cors";
config();

const server  = express();

server.use(express.json());
server.use(cors());
server.set("port", 3000);
server.use("/", routes);

export default server;