const{create,
  getAccessoireByIdAccessoire,
  getAccessoires,
  updateAccessoire,
  deleteAccessoire
}=require("./shop.service");
module.exports={
  createAccessoire:(req,res)=>{
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
  getAccessoireByIdAccessoire: (req, res) => {
    const id = req.params.id;
    getAccessoireByIdAccessoire(id, (err, results) => {
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
  getAccessoires: (req, res) => {
    getAccessoires((err, results) => {
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
  updateAccessoire: (req, res) => {
    const body = req.body;
    updateAccessoire(body, (err, results) => {
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
  deleteAccessoire: (req, res) => {
    const data = req.body;
    deleteAccessoire(data, (err, results) => {
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
