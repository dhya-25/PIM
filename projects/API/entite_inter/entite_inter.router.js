const{
  createPartie,
  getEntite_interById,
  getQuestionsInPartieByIdPartie,
  getPartiesInQuestionsByIdQuestions,
  getEntite_inter,
  updateEntite_inter,
  deleteEntite_inter
}=require("./entite_inter.controller");
const router = require("express").Router();
router.post("/",createPartie);
router.get("/:id",getEntite_interById);
router.get("/getQuestionsInGame/:id_partie",getQuestionsInPartieByIdPartie);
router.get("/getGamesInQuestions/:id_question",getPartiesInQuestionsByIdQuestions);

router.patch("/",updateEntite_inter);
router.delete("/",deleteEntite_inter);
router.get("/",getEntite_inter);

module.exports=router;
