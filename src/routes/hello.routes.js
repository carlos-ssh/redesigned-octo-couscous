import { Router } from 'express';
import { hello } from "../controllers/hello.controller.js";

const router = Router();

// router.use(corsMiddleware);
router.get("/", hello);
// router.post("/register", validateSchema(registerSchema), register);

export default router;
