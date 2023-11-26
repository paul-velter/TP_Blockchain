const http = require('http');

const server = http.createServer((req, res) => {
  // Gérer les requêtes ici
  res.writeHead(200, { 'Content-Type': 'text/plain' });
  res.end('Hello, World!\n');
});

const port = 3000; // Choisir le port que vous préférez

server.listen(port, () => {
  console.log(`Serveur en cours d'exécution sur http://localhost:${port}`);
});
