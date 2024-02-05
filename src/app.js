import express from 'express';
import xmlReader from './routes/xmlReader.routes.js';
import hello from './routes/hello.routes.js';

const app = express();

app.use(express.json());
app.use('/api', xmlReader);
app.use('/api', hello);

export default app;
