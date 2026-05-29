import cors from "cors";
import express from "express";

import { errorHandler, notFound } from "./middleware/error";
import { healthRouter } from "./routes/health";
import { usersRouter } from "./routes/users";

const app = express();

app.use(cors({ origin: true }));
app.use(express.json({ limit: "1mb" }));

app.get("/", (_req, res) => {
  res.json({
    name: "Dhiman Backend API",
    version: "1.0.0",
    routes: ["/health", "/users/me", "/users", "/users/:uid/role"]
  });
});

app.use("/health", healthRouter);
app.use("/users", usersRouter);

app.use(notFound);
app.use(errorHandler);

export { app };
