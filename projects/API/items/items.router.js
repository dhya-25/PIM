const{
  createAccessoire,
  getAccessoireByIdAccessoire,
  getAccessoires,
  updateAccessoire,
  deleteAccessoire
}=require("./accessoire.controller");
const router = require("express").Router();
router.post("/",createAccessoire);
router.get("/:id",getAccessoireByIdAccessoire);

router.patch("/",updateAccessoire);
router.delete("/",deleteAccessoire);
router.get("/",getAccessoires);

module.exports=router;
