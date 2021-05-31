const{
  createExp,
  getExpByIdUser,
  getExp,
  getCoinsByIdUser,
  get5050ByIdUser,
  getSTQByIdUser,
  getATAByIdUser,
  addCoins,
  consumeCoins,
  consume5050,
  consumeATA,
  consumeSTQ
}=require("./experience.controller");

const router = require("express").Router();


router.post("/",createExp);
router.get("/getExp/:id_user",getExpByIdUser);
router.get("/getCoins/:id_user",getCoinsByIdUser);
router.get("/get5050/:id_user",get5050ByIdUser);
router.get("/getSTQ/:id_user",getSTQByIdUser);
router.get("/getATA/:id_user",getATAByIdUser);
router.post("/addCoins",addCoins);
router.post("/consumeCoins",consumeCoins);
router.post("/consume5050",consume5050);
router.post("/consumeATA",consumeATA);
router.post("/consumeSTQ",consumeSTQ);
router.get("/",getExp);

module.exports=router;
