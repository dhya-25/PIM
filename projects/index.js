const express = require("express");
var md5 = require('md5');
var reverseMd5 = require('reverse-md5');
const app = express();
const userRouter = require("./API/users/user.router");
const questionsRouter = require("./API/questions/questions.router");

//const shopRouter = require("./API/shop/shop.router");
//const partieRouter = require("./API/partie/partie.router");
//const itemsRouter = require("./API/items/items.router");
//const experienceRouter = require("./API/experience/experience.router");
//const entite_interRouter = require("./API/entite_inter/entite_inter.router");

app.use(express.json());

app.use("/api/users", userRouter);
app.use("/api/questions", questionsRouter);



const port = process.env.APP_PORT || 3000;
app.listen(port, () => {
  console.log("server up and running on PORT :", port);
});
