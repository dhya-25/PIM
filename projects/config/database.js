const { createPool } = require("mysql");
const pool = createPool({
  host: 'localhost',
 port: 3306,
 user: 'root',
 password: '',
 database: 'fantazytest',
 connectionLimit: 100,
 multipleStatements: true
});
module.exports=pool;