import libxmljs2 from 'libxmljs2';
import multer from 'multer';

const upload = multer({ storage: multer.memoryStorage() });
export const validateXMLFile = upload.single('xml');

export const validateXMLContent = (req, res, next) => {
    try {
        if (!req.file) {
            throw new Error('XML file not found');
        }

        const xml = req.file.buffer.toString();
        const xmlDoc = libxmljs2.parseXmlString(xml);

        const ns = { cfdi: 'http://www.sat.gob.mx/cfd/4' };
        const tipoDeComprobante = xmlDoc.get('//cfdi:Comprobante/@TipoDeComprobante', ns);

        if (!tipoDeComprobante || tipoDeComprobante.value() !== 'I') {
            throw new Error('XML type not valid');
        }

        next();
    } catch (error) {
        res.status(400).send('Error validating XML file: ' + error.message);
    }
};
