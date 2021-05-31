const pool = require("../../config/database");
module.exports={
  create:(data,callback)=>{
    pool.query(
      `insert into accessoire(prix,couleur,type,photo,quantite,idtype) values(?,?,?,?,?,?)`,
      [
        data.prix,
        data.couleur,
        data.type,
        data.photo,
        data.quantite,
        data.idtype,
      ],
      (error,results,fields)=>{
        if(error){
         return callback(error);
        }
        return callback(null,results);
      }
    );
  },
  getAccessoireByIdAccessoire :(id, callback)=>{
    pool.query(
      `select * from accessoire where idaccessoire=? `,
      [id],
      (error,results,fields)=>{
        if(error){
         return callback(error);
        }
        return callback(null,results[0]);
      }
    );
  },
  getAccessoires: callback =>{
    pool.query(
      'select * from accessoire',
      [],
      (error,results,fields)=>{
        if(error){
         return callback(error);
        }
        return callback(null,results);
      }
    );
  },
  updateAccessoire: (data, callBack) => {
    pool.query(
       `update accessoire set prix=?,couleur=?,type=?,photo=?,quantite=?,idtype=? where idaccessoire = ?`,
      [
        data.prix,
        data.couleur,
        data.type,
        data.photo,
        data.quantite,
        data.idtype,
        data.id,
      ],
      (error, results, fields) => {
        if (error) {
         return callBack(error);
        }
        return callBack(null, results);
      }
    );
  },
  deleteAccessoire: (data, callBack) => {
    pool.query(
       `delete from accessoire where idaccessoire = ?`,
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
