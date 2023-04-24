const express = require('express');
const app = express();
const port = 3000;
const path = require('path');
const axios = require('axios');
const bodyParser = require('body-parser');
const cors = require('cors');

app.use(express.static('public'));
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());
app.use(cors()); // Add this line to enable CORS

app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

app.post('/square', async (req, res) => {
  const value = req.body.value;
  const url = 'http://backend/square';
  try {
    const response = await axios.post(url, { value });
    const result = response.data.result;
    res.send({ result });
  } catch (error) {
    console.error(error);
    res.status(500).send({ error: 'Unable to get result' });
  }
});

app.post('/squareroot', async (req, res) => {
  const value = req.body.value;
  const url = 'http://backend/squareroot';
  try {
    const response = await axios.post(url, { value });
    const result = response.data.result;
    res.send({ result });
  } catch (error) {
    console.error(error);
    res.status(500).send({ error: 'Unable to get result' });
  }
});

app.post('/cube', async (req, res) => {
  const value = req.body.value;
  const url = 'http://backend/cube';
  try {
    const response = await axios.post(url, { value });
    const result = response.data.result;
    res.send({ result });
  } catch (error) {
    console.error(error);
    res.status(500).send({ error: 'Unable to get result' });
  }
});

app.listen(port, () => {
  console.log(`Server listening at http://localhost:${port}`);
});