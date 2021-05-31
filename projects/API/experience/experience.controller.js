const{create,
  getExpByIdUser,
  getATAByIdUser,
  getSTQByIdUser,
  get5050ByIdUser,
  getCoinsByIdUser,
  getExp,
  addCoins,
  consumeCoins,
  consume5050,
  consumeATA,
  consumeSTQ
}=require("./experience.service");
module.exports={
  createExp:(req,res)=>{
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
  getExpByIdUser: (req, res) => {
    const id_user = req.params.id_user;
    getExpByIdUser(id_user, (err, results) => {
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
  getATAByIdUser: (req, res) => {
    const id_user = req.params.id_user;
    getATAByIdUser(id_user, (err, results) => {
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
  getSTQByIdUser: (req, res) => {
    const id_user = req.params.id_user;
    getSTQByIdUser(id_user, (err, results) => {
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
  getCoinsByIdUser: (req, res) => {
    const id_user = req.params.id_user;
    getCoinsByIdUser(id_user, (err, results) => {
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
  get5050ByIdUser: (req, res) => {
    const id_user = req.params.id_user;
    get5050ByIdUser(id_user, (err, results) => {
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
  getExp: (req, res) => {
    getExp((err, results) => {
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
  addCoins: (req, res) => {
    const body = req.body;
    const TypedCoins = parseInt(req.body.coins);
    const id_user = req.body.id_user;
    addCoins(id_user, TypedCoins ,(err, results) => {
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
        message: "Coins Added !!"
      });
    });
  },
  consumeCoins: (req, res) => {
    const body = req.body;
    const TypedCoins = parseInt(req.body.coins);
    const id_user = req.body.id_user;
    consumeCoins(id_user, TypedCoins ,(err, results) => {
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
        message: "Coins Consumed !!"
      });
    });
  },
  consume5050: (req, res) => {
    const id_user = req.body.id_user;
    consume5050(id_user,(err, results) => {
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
        message: "5050 Consumed !!"
      });
    });
  },
  consumeATA: (req, res) => {
    const id_user = req.body.id_user;
    consumeATA(id_user,(err, results) => {
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
        message: "ATA Consumed !!"
      });
    });
  },

  consumeSTQ: (req, res) => {
    const id_user = req.body.id_user;
    consumeSTQ(id_user,(err, results) => {
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
        message: "STQ Consumed !!"
      });
    });
  },

};
