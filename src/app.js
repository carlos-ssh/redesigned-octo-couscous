import express from 'express';
import xmlReader from './routes/xmlReader.routes.js';

const app = express();

app.use('/api', xmlReader);

export default app;
