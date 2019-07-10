const express = require('express');
const app = express();
const { name, version } = require('./package.json');
const port = process.env.PORT || 3000;
const environment = process.env.NODE_ENV;

app.get('/', (req, res) => res.status(200).json({
    name, version, environment
}));

app.listen(port, () => console.log(`${name} ${version} [${environment}] listening on port ${port}!`));

module.exports = app