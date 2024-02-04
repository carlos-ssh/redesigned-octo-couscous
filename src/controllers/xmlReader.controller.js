import extractInvoice from '../services/invoiceService.js';

export const xmlReader = async (req, res) => {
    try {
        const xml = await req.file.buffer.toString();
        const infoFactura = extractInvoice(xml);

        console.log("infoFactura ===>", infoFactura) // This console.log is for displaying results
        res.json(infoFactura);
    } catch (error) {
        res.status(500).send('Error processing invoice: ' + error.message);
    }
};
