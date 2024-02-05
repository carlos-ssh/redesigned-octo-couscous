import { Router } from 'express';
import { xmlReader } from "../controllers/xmlReader.controller.js";
import { validateXMLFile, validateXMLContent } from '../middlewares/validateXML.middleware.js';

const router = Router();

router.post('/xml-reader', validateXMLFile, validateXMLContent, xmlReader);

export default router;
