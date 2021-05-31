const pool = require("../../config/database");
const{create,
  getplayers,
  getQuestionsByCategory,
  getQuestions,
  getClub,
  setValide,
  CompareAnswers,
  updateQuestions,
  deleteQuestions,
  createfx,
  updatefixture,
  getAllScores,
  getPts
}=require("./questions.service");
module.exports={
  createQuestions:(req,res)=>{
    const body = req.body;
      create(body,(err,results)=>{
      if(err){
        console.log(err);
        return res.status(500).json({
          success:0,
          message:"database connexion error"
        });
      }
      return res.status(200).json({
        success:1,
        message:"success"
      });
    });
  },


  createFixtures:(req,res)=>{
    const body = req.body;
      createfx(body,(err,results)=>{
      if(err){
        console.log(err);
        return res.status(500).json({
          success:0,
          message:"database connexion error"
        });
      }
      return res.status(200).json({
        success:1,
        message:"success"
      });
    });
  },

  getAllScores:(req,res)=>{
    const body = req.body;
    var myArray = new Array();
    
      getScores(body,(err,results)=>{
      if(err){
        console.log(err);
        return res.status(500).json({
          success:0,
          message:"database connexion error"
        });
      }
      return res.status(200).json({
        success:1,
        message:"success",
        data:results
      });
    });
  },
  getplayers: (req, res) => {
    const id = req.params.id;
    getplayers(id, (err, results) => {
      if (err) {
        console.log(err);
        return;
      }
      if (!results) {
        return res.json({
          success: 0,
          message: "Record not Found"
        });
      }

      return res.json({
        success: 1,
        data: results
      });
    });
  },

  CompareAnswers: (req, res) => {
    const idU = req.body.idU;
    const idQ = req.body.idQ;
    const answer = req.body.answer;
    CompareAnswers(idU, idQ, answer , (err, results) => {
      if (err) {
        console.log(err);
        return;
      }
      if (!results) {
        return res.json({
          success: 0,
          message: "Record not Found"
        });
      }

      return res.json({
        success: 1,
        data: results
      });
    });
  },

  UpdateFixtures:(req,res)=>{
    const body = req.body;
    var myArray = new Array();
    
      updatefixture(body,(err,results)=>{
      if(err){
        console.log(err);
        return res.status(500).json({
          success:0,
          message:"database connexion error"
        });
      }
      return res.status(200).json({
        success:1,
        message:"success",
        data:results
      });
    });
  },

  getPoints:(req,res)=>{
    const body = req.body;
    var myArray = new Array();
    
      getPts(body,(err,results)=>{
      if(err){
        console.log(err);
        return res.status(500).json({
          success:0,
          message:"database connexion error"
        });
      }
      return res.status(200).json({
        success:1,
        message:"success",
        data:results
      });
    });
  },


  getClub:(req,res)=>{
    const body = req.body;
    var myArray = new Array();
    
      getClub(body,(err,results)=>{
      if(err){
        console.log(err);
        return res.status(500).json({
          success:0,
          message:"database connexion error"
        });
      }
      return res.status(200).json({
        success:1,
        data:results
      });
    });
  },
  getQuestionsByCategory: (req,res) =>{
    const category =req.body.category;
    getQuestionsByCategory(category, (err, results) => {
      if (err) {
        console.log(err);
        return;
      }
      if (!results) {
        return res.json({
          success: 0,
          message: "Record not Found!!!"
        });
      }
      return res.json({
        success: 1,
        data: results
      });
    });
  },


  getQuestions: (req, res) => {
    getQuestions((err, results) => {
      if (err) {
        console.log(err);
        return;
      }
      return res.json({
        success: 1,
        data: results
      });
    });
  },

  /*getQuestionsByCategory: (req, res) => {
    var allresults="";
      for(var i=0;i<=10;i++){
      let category = req.body.category[i];
      pool.query(`select * from questions where category=?`,[category],
      function (err,results) {
        if (err) {
          console.log(err);
          return;
        }
        if (!results) {
          return res.json({
            success: 0,
            message: "Record not Found"
          });
        } else{
          var resultsInString= JSON.stringify(results);
          allresuts=allresuts.concat(resultsInString);
          return res.json(allresuts);
        }
      
    });}
    category.forEach(Element => {
      console.log(Element);
      pool.query(`select * from questions where category =? and valide=1`,[Element],
      function (err,results) {
        if (err) {
          console.log(err);
          return;
        }
        if (!results) {
          return res.json({
            success: 0,
            message: "Record not Found"
          });
        } 
        else{
          var resultsInString= JSON.stringify(results);
          allresults=allresults.concat(resultsInString);
          var resl = JSON.parse(allresults);    
          return res.json(resl);

        }
      });
    }) 

     
  },
  */
  
    /*pool.query(`select * from questions where valide = 1 and category=?`,[category],
      function (err,results) {
      if (err) {
        console.log(err);
        return;
      }
      if (!results) {
        return res.json({
          success: 0,
          message: "Record not Found"
        });
      } 
      else {
        return res.json(results)
      }
      
      });
  },*/

 

  updateQuestions: (req, res) => {
    const body = req.body;
    updateQuestions(body, (err, results) => {
      if (err) {
        console.log(err);
        return false ;
      }
      if (!results){
        return res.json({
          success: 0 ,
          message: "failed"
        });
      }
      return res.json({
        success: 1,
        message: "updated successfully"
      });
    });
  },
  setValide: (req, res) => {
    const body = req.body;
    setValide(body, (err, results) => {
      if (err) {
        console.log(err);
        return false ;
      }
      if (!results){
        return res.json({
          success: 0 ,
          message: "failed"
        });
      }
      return res.json({
        success: 1,
        message: "updated successfully"
      });
    });
  },
  deleteQuestions: (req, res) => {
    const data = req.body;
    deleteQuestions(data, (err, results) => {
      if (err) {
        console.log(err);
        return;
      }
      if (!results) {
        return res.json({
          success: 0,
          message: "Record Not Found"
        });
      }
      return res.json({
        success: 1,
        message: "Question deleted successfully"
      });
    });
  },
};
