const{create,
  getEntite_interById,
  getQuestionsInPartieByIdPartie,
  getPartiesInQuestionsByIdQuestions,
  getEntite_inter,
  updateEntite_inter,
  deleteEntite_inter
}=require("./entite_inter.service");
module.exports={
  createPartie:(req,res)=>{
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
        data:results
      });
    });
  },
  getEntite_interById: (req, res) => {
    const id = req.params.id;
    getEntite_interById(id, (err, results) => {
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
  getQuestionsInPartieByIdPartie: (req, res) => {
    const id_partie = req.params.id_partie;
    getQuestionsInPartieByIdPartie(id_partie, (err, results) => {
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

  getPartiesInQuestionsByIdQuestions: (req, res) => {
    const id_question = req.params.id_question;
    getPartiesInQuestionsByIdQuestions(id_question, (err, results) => {
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

  getEntite_inter: (req, res) => {
    getEntite_inter((err, results) => {
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
  updateEntite_inter: (req, res) => {
    const body = req.body;
    updateEntite_inter(body, (err, results) => {
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
  deleteEntite_inter: (req, res) => {
    const data = req.body;
    deleteEntite_inter(data, (err, results) => {
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
        message: "Entite Inter deleted successfully"
      });
    });
  },
};
