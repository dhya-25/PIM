const pool = require("../../config/database");

module.exports = {
  
  create: (data, callBack) => {
    pool.query(
      `insert into user(name,email,equipe,password) values(?,?,?,?)`,
      [
        data.name,
        data.email,
        data.equipe,
        data.password,
      ],
      (error, results, fields) => {
        
        if (error) {
          callBack(error);
        }
        return callBack(null, results);
        
      }
    );
  },
  
  getUserByUserEmail: (email, callBack) => {
    pool.query(
       `select * from user where email = ?`,
      [email],
      (error, results, fields) => {
        if (error) {
         callBack(error);
        }
        return callBack(null, results[0]);
      }
    );
  },


  getUserByUserEmailFantasy: (email, callBack) => {
    pool.query(
       `select * from club where email = ?   `,
      [email],
      (error, results, fields) => {
        if (error) {
         return callBack(error);
        }
        return callBack(null, results[0]);
      }
    );
  },


  getUserByUserId: (id, callBack) => {
    pool.query(
      `select id,name,email,equipe,password from user where id = ?`,
      [id],
      (error, results, fields) => {
        if (error) {
        return  callBack(error);
        }
        return callBack(null, results[0]);
      }
    );
  },

  getUsers: callBack => {
    pool.query(
      `select id,name,email,equipe,password from user` ,
      [],
      (error, results, fields) => {
        if (error) {
        return  callBack(error);
        }
        return callBack(null, results);
      }
    );
  },
  updateUser: (data, callBack) => {
    pool.query(
       `update user set userName=?, email=?, password=?, rank=?, score=?, role=?, nom=?, prenom=? where id = ?`,
      [
        
        data.userName,
        data.email,
        data.password,
        data.rank,
        data.score,
        data.role,
        data.nom,
        data.prenom,
        data.id
      ],
      (error, results, fields) => {
        if (error) {
         return callBack(error);
        }
        return callBack(null, results);
      }
    );
  },
  deleteUser: (data, callBack) => {
    pool.query(
       `delete from user where id = ?`,
      [data.id],
      (error, results, fields) => {
        if (error) {
         return callBack(error);
        }
        return callBack(null, results);
      }
    );
  }
  
};
