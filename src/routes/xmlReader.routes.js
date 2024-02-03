import { Router } from 'express';
import { xmlReader } from "../controllers/xmlReader.controller.js";

const router = Router();

// router.use(corsMiddleware);
router.post("/", xmlReader);
// router.post("/register", validateSchema(registerSchema), register);

export default router;
