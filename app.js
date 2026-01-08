const express = require('express');
const app = express();

const PORT = 8080;

app.get('/', (req, res) => {
  res.send('✅ Backend is running successfully!');
});

app.get('/health', (req, res) => {
  res.status(200).json({ status: 'UP' });
});

app.listen(PORT, () => {
  console.log(`🚀 Server running on port ${PORT}`);
});
