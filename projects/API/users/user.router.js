const {
  createUser,
  getUserByUserId,
  getUsers,
  updateUsers,
  deleteUser,
  verifyEmailForReset,
  verify_user,
  verify_user_forReset,
  updatepassword,
  login,
  loginFantazy
}=require("./user.controller");
const router = require("express").Router();
router.get("/",getUsers);


router.post("/adduser",createUser);
router.get("/:id",getUserByUserId);
router.post("/verifcode",verify_user);
router.post("/verifyEmailForReset",verifyEmailForReset);
router.post("/updatepassword",updatepassword);
router.post("/verify_user_forReset",verify_user_forReset);

router.patch("/",updateUsers);
router.delete("/",deleteUser);
router.post("/login",login);
router.post("/loginFantazy",loginFantazy);

module.exports=router;