const pool = require("../../config/database");
module.exports={
  create:(data,callback)=>{
    pool.query(
      `insert into partie(current_question,energy,id_user,id_shop) values(?,?,?,?)`,
      [
        data.current_question,
        data.energy=5,
        data.id_user,
        data.id_shop,
      ],
      (error,results,fields)=>{
        if(error){
         return callback(error);
        }
        return callback(null,results);
      }
    );
  },
  getPartieByIdUser :(id, callback)=>{
    pool.query(
      `select * from partie where id_user=? `,
      [id],
      (error,results,fields)=>{
        if(error){
         return callback(error);
        }
        return callback(null,results[0]);
      }
    );
  },
  getPartie: callback =>{
    pool.query(
      'select * from partie',
      [],
      (error,results,fields)=>{
        if(error){
        return  callback(error);
        }
        return callback(null,results);
      }
    );
  },
  updatePartie: (data, callBack) => {
    pool.query(
       `update partie set current_question=?,energy=?,id_user=?,id_shop=? where id_user = ?`,
      [
        data.current_question,
        data.energy,
        data.id_user,
        data.id_shop,
        data.id,
      ],
      (error, results, fields) => {
        if (error) {
        return  callBack(error);
        }
        return callBack(null, results);
      }
    );
  },
  deletePartie: (data, callBack) => {
    pool.query(
       `delete from partie where id_user = ?`,
      [data.id_user],
      (error, results, fields) => {
        if (error) {
        return  callBack(error);
        }
        return callBack(null, results);
      }
    );
  }


};
