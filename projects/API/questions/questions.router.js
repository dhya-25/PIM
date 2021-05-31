const{
  createQuestions,
  createFixtures,
  getplayers,
  getQuestions,
  getQuestionsByCategory,
  getClub,
  CompareAnswers,
  setValide,
  updateQuestions,
  UpdateFixtures,
  deleteQuestions,
  getPoints,
  getAllScores,
  
}=require("./questions.controller");
const router = require("express").Router();

router.post("/addQuestion",createQuestions);
router.post("/addFixture",createFixtures);
router.post("/getPoints",getPoints);
router.get("/:id",getplayers);
router.post("/updateQuestion",updateQuestions);
router.post("/updatesFixtures",UpdateFixtures);
router.delete("/",deleteQuestions);
router.get("/",getQuestions);
router.post("/getclub",getClub);
router.post("/getByCategory",getQuestionsByCategory);
router.post("/setValide", setValide);
router.post("/CompareAnswers", CompareAnswers);
router.post("/getallscores",getAllScores);
module.exports=router;
