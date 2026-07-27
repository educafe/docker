const express = require('express');
const mysql = require('mysql');

const app = express();

const db_config = {
  host     : 'mysql',
  user     : 'testuser',
  password : 'testpassword',
  database : 'testdb'
};

let db;

function handleDisconnect() {
  db = mysql.createConnection(db_config);

  db.connect((err) => {
    if(err) {
      console.log('Error connecting to database:', err);
      setTimeout(handleDisconnect, 2000); // Retry after 2 seconds
    } else {
      console.log('Connected to database');
    }
  });

  db.on('error', (err) => {
    console.log('Database error', err);
    if(err.code === 'PROTOCOL_CONNECTION_LOST') {
      handleDisconnect(); // Reconnect on lost connection
    } else {
      throw err;
    }
  });
}

handleDisconnect();

app.get('/', (req, res) => {
  res.send('Hello from Node.js app\n');
});

app.get('/users', (req, res) => {
  let sql = 'SELECT * FROM users';
  db.query(sql, (err, results) => {
    if(err) {
      res.send('Error fetching users: ' + err);
    } else {
      res.json(results);
    }
  });
});

app.listen(3000, () => {
  console.log('Server started on port 3000');
});
