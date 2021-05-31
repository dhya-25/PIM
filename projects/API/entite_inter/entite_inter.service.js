const pool = require("../../config/database");
module.exports={
  create:(data,callback)=>{
    pool.query(
      `insert into entite_inter(id_partie,id_question) values(?,?)`,
      [
        data.id_partie,
        data.id_question,
      ],
      (error,results,fields)=>{
        if(error){
         return callback(error);
        }
        return callback(null,results);
      }
    );
  },
  getEntite_interById :(id, callback)=>{
    pool.query(
      `select * from entite_inter where id=? `,
      [id],
      (error,results,fields)=>{
        if(error){
         return callback(error);
        }
        return callback(null,results[0]);
      }
    );
  },

  getQuestionsInPartieByIdPartie :(id, callback)=>{
    pool.query(
      `select * from entite_inter where id_partie=? `,
      [id],
      (error,results,fields)=>{
        if(error){
         return callback(error);
        }
        return callback(null,results);
      }
    );
  },

  getPartiesInQuestionsByIdQuestions :(id, callback)=>{
    pool.query(
      `select * from entite_inter where id_question=? `,
      [id],
      (error,results,fields)=>{
        if(error){
         return callback(error);
        }
        return callback(null,results);
      }
    );
  },

  getEntite_inter: callback =>{
    pool.query(
      'select * from entite_inter',
      [],
      (error,results,fields)=>{
        if(error){
         return callback(error);
        }
        return callback(null,results);
      }
    );
  },
  updateEntite_inter: (data, callBack) => {
    pool.query(
       `update entite_inter set id_partie=?,id_question=? where id = ?`,
      [
        data.id_partie,
        data.id_question,
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
  deleteEntite_inter: (data, callBack) => {
    pool.query(
       `delete from entite_inter where id = ?`,
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
