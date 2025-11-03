const express = require('express');
const app = express();
const port = process.env.PORT || 8080;
app.get('/', (_, res) => res.json({service:'sample', status:'ok'}));
app.listen(port, () => console.log(`sample listening on ${port}`));
