const{
  createPartie,
  getPartieByIdUser,
  getPartie,
  updatePartie,
  deletePartie
}=require("./partie.controller");
const router = require("express").Router();
router.post("/addPartie",createPartie);
router.get("/:id_user",getPartieByIdUser);

router.patch("/",updatePartie);
router.delete("/",deletePartie);
router.get("/",getPartie);

module.exports=router;
