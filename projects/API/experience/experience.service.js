const pool = require("../../config/database");
module.exports={
  create:(data,callback)=>{
    pool.query(
      `insert into experience(coins,5050,skipTheQuestion,ATA,id_user) values(?,?,?,?,?,?)`,
      [
        data.coins=1000,
        data.fiftyfifty=0,
        data.skipTheQuestion=0,
        data.ATA=0,
        data.id_user
      ],
      (error,results,fields)=>{
        if(error){
         return callback(error);
        }
        return callback(null,results);
      }
    );
  },
  getExpByIdUser :(id_user, callback)=>{
    pool.query(
      `select * from experience where id_user=? `,
      [id],
      (error,results,fields)=>{
        if(error){
         return callback(error);
        }
        return callback(null,results[0]);
      }
    );
  },
  get5050ByIdUser :(id_user, callback)=>{
    pool.query(
      `select 5050 from experience where id_user=? `,
      [id],
      (error,results,fields)=>{
        if(error){
         return callback(error);
        }
        return callback(null,results[0]);
      }
    );
  },
  getATAByIdUser :(id_user, callback)=>{
    pool.query(
      `select ATA from experience where id_user=? `,
      [id],
      (error,results,fields)=>{
        if(error){
         return callback(error);
        }
        return callback(null,results[0]);
      }
    );
  },
  getSTQByIdUser :(id_user, callback)=>{
    pool.query(
      `select skipTheQuestion from experience where id_user=? `,
      [id],
      (error,results,fields)=>{
        if(error){
         return callback(error);
        }
        return callback(null,results[0]);
      }
    );
  },
  getCoinsByIdUser :(id_user, callback)=>{
    pool.query(
      `select coins from experience where id_user=? `,
      [id],
      (error,results,fields)=>{
        if(error){
         return callback(error);
        }
        return callback(null,results[0]);
      }
    );
  },
  getExp: callback =>{
    pool.query(
      'select * from experience',
      [],
      (error,results,fields)=>{
        if(error){
         return callback(error);
        }
        return callback(null,results);
      }
    );
  },
  addCoins: (id_user, TypedCoins, callBack) => {
    pool.query(
       `update experience set coins=coins+@TypedCoins where id_user = ?`,
      [
        id_user,
        TypedCoins
      ],
      (error, results, fields) => {
        if (error) {
         return callBack(error);
        }
        return callBack(null, results);
      }
    );
  },
  consumeCoins: (id_user, TypedCoins, callBack) => {
    pool.query(
       `update experience set coins=coins-@TypedCoins where id_user = ?`,
      [
        id_user,TypedCoins
      ],
      (error, results, fields) => {
        if (error) {
         return callBack(error);
        }
        return callBack(null, results);
      }
    );
  },
  consume5050: (id_user, callBack) => {
    pool.query(
       `update experience set 5050=5050-1 where id_user = ?`,
      [
        id_user
      ],
      (error, results, fields) => {
        if (error) {
         return callBack(error);
        }
        return callBack(null, results);
      }
    );
  },
  consumeATA: (id_user, callBack) => {
    pool.query(
       `update experience set ATA=ATA-1 where id_user = ?`,
      [
        id_user
      ],
      (error, results, fields) => {
        if (error) {
         return callBack(error);
        }
        return callBack(null, results);
      }
    );
  },

  consumeSTQ: (id_user, callBack) => {
    pool.query(
       `update experience set skipTheQuestion=skipTheQuestion-1 where id_user = ?`,
      [
        id_user
      ],
      (error, results, fields) => {
        if (error) {
         return callBack(error);
        }
        return callBack(null, results);
      }
    );
  },


};
