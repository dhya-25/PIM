const { json } = require("express");
const mysql = require('mysql2');
const request = require('request');
const pool = require("../../config/database");
module.exports={
  create:(data,callback)=>{
    var myArray = new Array();
    console.log(data);
    data.players.forEach((player) => {
  
    var playerModel ={
      id : player.id,
      firstname : player.firstname,
      lastname : player.lastname,
      position : player.position,
      price : player.price,
      rating: player.rating,
      appearences : player.appearences,
      goals : player.goals,
      assists : player.assists,
      cleansheets : player.cleansheets,
      redcards : player.redcards,
      yellowcards : player.yellowcards,
      image : player.image,
      teamid: player.teamid,
      fixtureid: player.fixtureid
    };
    console.log("model"+playerModel.rating);
    myArray.push(playerModel);
  });
  var id;
   
   pool.query(
        'insert into club(userid,email,password,name,price,points,fixture) values(?,?,?,?,?,?,?)',
     [
          data.userid,
          data.email,
          data.password,
          data.name,
          data.price,
          data.points=0,
          data.fixture="0"

        ],
      
        (error,result) => {
          
          if(error){
            return callback(error);
           
          }else{
          for(var item of myArray){

            pool.query(
              
              'insert into players(id,firstname,lastname,position,price,rating,appearences,goals,assists,cleansheets,redcards,yellowcards,image,teamid,fixtureid,clubid) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?, ( SELECT id from club where id > ? ORDER BY id DESC limit 1  ) )',
               [ 
               item.id,
               item.firstname,
               item.lastname,
               item.position,
               item.price,
               item.rating,
               item.appearences,
               item.goals,
               item.assists,
               item.cleansheets,
               item.redcards,
               item.yellowcards,
               item.image,
               item.teamid,
               1,
               0
               ],
              
            );
          }
            }
           
          return callback(null,result);
        },      
      );

    },

    createfx:(data,callback)=>{

      var myArray = new Array();
      console.log(data);
      data.fixt.forEach((player) => {
    
      var FixtureModel ={
        id : player.id,
        round : player.round,
      };
      console.log("model"+FixtureModel.id);
      myArray.push(FixtureModel);
    });
            for(var item of myArray){
              pool.query(
                'insert into fixtures(id,round) values (?,?)',
                 [ 
                 item.id,
                 item.round
                 ],
        );
        }
        (error,result) => {  
          if(error){
            console.log(error);
            return callback(error);
          }
          return callback(null,result);
  }
      },

      getScores:(data,callback)=>{

        var myArray = new Array();
        console.log(data);

                pool.query(
                  'Select sum(squad.points) as points ,club.id,club.email,club.name, user.name as username  from club,squad,user where squad.clubid = club.id and user.id = club.userid group by id order by points desc',
                   [ 
                   ],
                   (error,result) => {  
                    if(error){
                      console.log(error);
                      return callback(error);
                    }
                    console.log(result);
                    return callback(null,result);
            }
          );
          
        },
      getPts:(data,callback)=>{

        var myArray = new Array();
        console.log(data);

                pool.query(
                  'Select sum(points) as points from squad where clubid = ?',
                   [ 
                   data.clubid
                   ],
                   (error,result) => {  
                    if(error){
                      console.log(error);
                      return callback(error);
                    }
                    console.log(result);
                    return callback(null,result);
            }
          );
          
        },
  
  

      updatefixture:(data,callback)=>{
        function addPlayer(item) {
             return new Promise((accept, reject) => {
                 pool.query('UPDATE squad SET appearences = 1, rating = ?, goals = ?, assists = ? , cleansheets = ?, redcards = ?, yellowcards = ? , points = ? WHERE id = ? AND fixtureid = ? ',
                  [ 
                  item.rating,
                  item.goals,
                  item.assists,
                  item.cleansheets,
                  item.redcards,
                  item.yellowcards,
                  item.points,
                  item.id,
                  item.fixtureid
              ], (error, result) => {  
                 if(error){
                   reject(error);
                 } else {
                   accept(result);
                 }
             });
           });
         }
           
         console.log(JSON.stringify(data));
   
         Promise.all(data.players.map(addPlayer)).then((result)=>{
           return callback(null,result);
           console.log(result)
         }).catch((error)=>{
           console.log('Error:', error)
           return callback(error);
         })
    },
  
  getClub:(data, callback) => {
    console.log(data);
    var myArray = new Array();
    var sql = "select * from club where id= ?;select * from squad where clubid= ?";
    pool.query(
    sql,
      [data.clubid,data.clubid],
      (error,results)=>{
        if(error){
         return callback(error);
        }
		//console.log(results[0]);
    //console.log(results[1]);
    results[1].forEach((player) => {
      var playerModel ={
        id : player.id,
        firstname : player.firstname,
        lastname : player.lastname,
        position : player.position,
        price : player.price,
        appearences : player.appearences,
        rating: player.rating,
        teamid: player.teamid,
        goals : player.goals,
        assists : player.assists,
        cleansheets : player.cleansheets,
        redcards : player.redcards,
        yellowcards : player.yellowcards,
        image : player.image,
        teamid: player.teamid,
        clubid: player.clubid,
        round: player.round,
        fixtureid: player.fixtureid,
        points: player.points
      };
      myArray.push(playerModel);
    });
    console.log(results[0]);
    var club;
    results[0].forEach((item) => {
       club ={
        id : item.id,
        email : item.email,
        password: item.password,
        name: item.name,
        price: item.price,
        points: item.points,
        fixture: item.fixture,
        userid: item.userid
      };
    });
    console.log("club"+club);
    var clubModel ={
      id : club.id,
      email : club.email,
      password: club.password,
      name: club.name,
      price: club.price,
      points: club.points,
      fixture: club.fixture,
      userid: club.userid,
      players: myArray
    };
    console.log(clubModel);
        return callback(null,clubModel);
      }
    );
  },
  
  
  
  getplayers :(id, callback)=>{
    pool.query(
      `select firstname,lastname from players where clubid=? `,
      [id],
      (error,results,fields)=>{
        if(error){
         return callback(error);
        }
        return callback(null,results[0]);
      }
    );
  },

  
  
  CompareAnswers:(idU, idQ, answer, callback)=> {
    pool.query(`select reponse_correcte from questions where id=?`,[idQ],
    (error,results)=>{
      var dataaaa = JSON.stringify(results[0]);
      var results1= JSON.parse(dataaaa).reponse_correcte;
      console.log(results1);
      console.log(idU);
      console.log(idQ);
      console.log(answer);
      if(error){
       return callback(error);
        return callback(null, results1);
      }
      else if(results1===answer) {
          pool.query(`update user set score=score + 200 where id=?`,[idU],
          (error, results2)=> {
            if(error) callback(error);
            return callback(null, results2);
          }
          );
      }
      else {
        pool.query(`update user set score=score - 200 where id=?`,[idU],
        (error, results3)=> {
          if(error) callback(error);
          return callback(null, results3);
        }
        );

      }
    }
    )
  },
  getQuestionsByCategory :(category, callback)=>{
    pool.query(
      `select * from questions where valide=1 AND category=?`,
      [category],
      (error,results,fields)=>{
        if(error){
          return callback(error);
        }
        return callback(null,results);
      }
    );
  },

  getQuestions: callback =>{
    pool.query(
      'select * from league_table ',
      [],
      (error,results,fields)=>{
        if(error){
          return callback(error);
        }
        return callback(null,results);
      }
    );
  },


  updateQuestions: (data, callback) => {
   
    console.log(data);
    pool.query(
      'delete from players where clubid =?;delete from squad where round like ? ',
   [
        data.userid,
        '%'+data.fixture+'%'

      ],
      (error,result) => {
        if(error){
          return callback(error);
         
        }
        for(var item of data.players){
          var sql =  'insert into squad(id,firstname,lastname,position,price,rating,appearences,goals,assists,cleansheets,redcards,yellowcards,image,teamid,round,clubid,fixtureid) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)';
          pool.query(
          
            'insert into players(id,firstname,lastname,position,price,rating,appearences,goals,assists,cleansheets,redcards,yellowcards,image,teamid,clubid,fixtureid) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);',
             [ 
             item.id,
             item.firstname,
             item.lastname,
             item.position,
             item.price,
             item.rating,
             item.appearences,
             item.goals,
             item.assists,
             item.cleansheets,
             item.redcards,
             item.yellowcards,
             item.image,
             item.teamid,
             item.clubid,
             item.fixtureid
             ],
          
          );
          pool.query(
          
            sql,
             [ 
             item.id,
             item.firstname,
             item.lastname,
             item.position,
             item.price,
             item.rating,
             item.appearences,
             item.goals,
             item.assists,
             item.cleansheets,
             item.redcards,
             item.yellowcards,
             item.image,
             item.teamid,
             data.fixture,
             item.clubid,
             item.fixtureid
             ],
          
          );
          }

        
        return callback(null,result);
      },

      
    );

  },
  setValide: (data, callBack) => {
    pool.query(
       `update questions set valide=1 where id = ?`,
      [
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

  deleteQuestions: (data, callBack) => {
    pool.query(
       `delete from questions where id = ?`,
      [data.id],
      (error, results, fields) => {
        if (error) {
        return  callBack(error);
        }
        return callBack(null, results);
      }
    );
  }


};
