---
runme:
  id: 01HNV3RPVH7C1960ZC2T7XECQS
  version: v2.2
---

# XML Validator
Este servicio recibe una petición **POST** con Express el cual permite recibir un archivo XML de una factura.
La solicitud se utiliza para extraer información básica de la factura.
La información extraída se devolvuelve en un .JSON una estructura como este ejemplo:
```
{
  total: '23780',
  uuid: '234b99e8-a2f5-4034-b8b5-192ad7ae5b64',
  fecha_timbrado: '2023-12-10T19:55:20',
  emisor: {
    rfc: 'EKU9003173C9',
    nombre: 'ESCUELA KEMPER URGATE',
    regimen_fiscal: '601'
  },
  receptor: {
    rfc: 'CACX7605101P8',
    nombre: 'XOCHILT CASAS CHAVEZ',
    regimen_fiscal: 'G03'
  }
}
```

- Antes de probar este proyecto es necesario considerar tener instalado [NodeJS](https://nodejs.org/en/blog/release/v20.9.0)
- En la versión local en donde se desarrolló fue en la versión `v20.9.0`

Si ya cuentas con algúna version de NodeJS instalada puedes validar la versión con el siguiente comando en la consola: `node -v`

## Instalación
- Instala el repositorio en tu computadora en el directorio de tu elección con el siguiente comando:

```
git clone https://github.com/carlos-ssh/redesigned-octo-couscous.git
```

- Ingresa al directorio del proyecto instalado:

```
cd redesigned-octo-couscous
```

- Una vez dentro del directorio del proyecto corre la instalación de las dependencias necesarias para el funcionamiento con el siguiente comando:

```
npm install
```

## Funcionalidad
Para activar el servicio usa:

```
npm run dev
```

Para usar el archivo XML de prueba puedes encontrarlo en el directorio `./public/files` del proyecto, el nombre del archivo es: `factura_prueba.xml`

- Para dar uso a este comando de ejemplo es necesario tener instalado [CURL](https://curl.se/download.html)
- En el comando hace una petición POST a `http://localhost:3000/api/xml-reader`
- Agrega un archivo desde el directorio publico `public/files/factura_prueba.xml`

Puedes copiar y pegar el siguiente comando:

```
curl -X POST -F "xml=@public/files/factura_prueba.xml" http://localhost:3000/api/xml-reader
```

Hay un `console.log` en donde te muestra el 'Objeto JSON' de salida. Así mismo envía una respuesta en el mismo formato
Ejemplo:

```
{
  total: '23780',
  uuid: '234b99e8-a2f5-4034-b8b5-192ad7ae5b64',
  fecha_timbrado: '2023-12-10T19:55:20',
  emisor: {
    rfc: 'EKU9003173C9',
    nombre: 'ESCUELA KEMPER URGATE',
    regimen_fiscal: '601'
  },
  receptor: {
    rfc: 'CACX7605101P8',
    nombre: 'XOCHILT CASAS CHAVEZ',
    regimen_fiscal: 'G03'
  }
}
```

Si tienes algún problema puedes [Crear un Issue](https://github.com/carlos-ssh/redesigned-octo-couscous/issues)
