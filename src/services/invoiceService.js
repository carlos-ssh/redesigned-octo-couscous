import libxmljs2 from 'libxmljs2';

const extractInvoice = (xml) => {
    const xmlDoc = libxmljs2.parseXmlString(xml);

    const ns = {
        cfdi: 'http://www.sat.gob.mx/cfd/4',
        tfd: 'http://www.sat.gob.mx/TimbreFiscalDigital'
    };

    const totalNode = xmlDoc.get('//cfdi:Comprobante/@Total', ns);
    const total = totalNode ? totalNode.value() : undefined;

    const uuidNode = xmlDoc.get('//cfdi:Complemento/tfd:TimbreFiscalDigital/@UUID', ns);
    const uuid = uuidNode ? uuidNode.value() : undefined;

    const fechaTimbradoNode = xmlDoc.get('//cfdi:Complemento/tfd:TimbreFiscalDigital/@FechaTimbrado', ns);
    const fechaTimbrado = fechaTimbradoNode ? fechaTimbradoNode.value() : undefined;

    const emisorRFCNode = xmlDoc.get('//cfdi:Emisor/@Rfc', ns);
    const emisorRFC = emisorRFCNode ? emisorRFCNode.value() : undefined;

    const emisorNombreNode = xmlDoc.get('//cfdi:Emisor/@Nombre', ns);
    const emisorNombre = emisorNombreNode ? emisorNombreNode.value() : undefined;

    const emisorRegimenFiscalNode = xmlDoc.get('//cfdi:Emisor/@RegimenFiscal', ns);
    const emisorRegimenFiscal = emisorRegimenFiscalNode ? emisorRegimenFiscalNode.value() : undefined;

    const receptorRFCNode = xmlDoc.get('//cfdi:Receptor/@Rfc', ns);
    const receptorRFC = receptorRFCNode ? receptorRFCNode.value() : undefined;

    const receptorNombreNode = xmlDoc.get('//cfdi:Receptor/@Nombre', ns);
    const receptorNombre = receptorNombreNode ? receptorNombreNode.value() : undefined;

    const receptorRegimenFiscalNode = xmlDoc.get('//cfdi:Receptor/@UsoCFDI', ns);
    const receptorRegimenFiscal = receptorRegimenFiscalNode ? receptorRegimenFiscalNode.value() : undefined;

    return {
        total,
        uuid,
        fecha_timbrado: fechaTimbrado,
        emisor: {
            rfc: emisorRFC,
            nombre: emisorNombre,
            regimen_fiscal: emisorRegimenFiscal
        },
        receptor: {
            rfc: receptorRFC,
            nombre: receptorNombre,
            regimen_fiscal: receptorRegimenFiscal
        }
    };
};

export default extractInvoice;
