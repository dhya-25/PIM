const{create,
  getPartieByIdUser,
  getPartie,
  updatePartie,
  deletePartie
}=require("./partie.service");
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
  getPartieByIdUser: (req, res) => {
    const id_user = req.params.id_user;
    getPartieByIdUser(id_user, (err, results) => {
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
  getPartie: (req, res) => {
    getPartie((err, results) => {
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
  updatePartie: (req, res) => {
    const body = req.body;
    updatePartie(body, (err, results) => {
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
  deletePartie: (req, res) => {
    const data = req.body;
    deletePartie(data, (err, results) => {
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
        message: "Accessoire deleted successfully"
      });
    });
  },
};
