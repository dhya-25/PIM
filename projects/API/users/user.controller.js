const pool = require("../../config/database");
var nodemailer = require('nodemailer');
var randomize = require('randomatic');
var md5 = require('md5');
const {create,
  getUsers,
  getUserByUserId,
  updateUser,
  deleteUser,
  getUserByUserEmail,
  login,
  getUserByUserEmailFantasy
} = require("./user.service");


var transporter = nodemailer.createTransport({
  service: 'gmail',
  auth: {
    user: 'dhyagg@gmail.com',
    pass: 'espirance0000'
  }
});

function sendVerificationEmail(email,user){
  let randomCode = randomize('0', 5);
  var mailOptions = {
    from: 'dhyagg@gmail.com',
    to: email,
    subject: 'Account Verification',
    html: "<center><h1>You can use this code to verify your account:  <p style='color:#FF0000';> "+randomCode+"</p> </h1></center>"
  };
  transporter.sendMail(mailOptions, function(error, info){
    if (error) 
    {
      console.log(error);
    } 
    else 
    {
      console.log('Email sent: ' + info.response);
      pool.query("INSERT INTO verification_code (idUser, codeverification) VALUES(?,?)", [user, randomCode]);
    }
    });

    
}

function sendVerificationEmailForResetPass(email,iduser){
  let randomCode = randomize('0', 5);
  var mailOptions = {
    from: 'dhyagg@gmail.com',
    to: email,
    subject: 'Reset password email verification',
    html: "<center><h1>You can use this code to change your password:  <p style='color:#FF0000';> "+randomCode+"</p> </h1></center>"
  };
  transporter.sendMail(mailOptions, function(error, info){
    if (error) 
    {
      console.log(error);
    } 
    else 
    {
      console.log('Email sent: ' + info.response);
      pool.query("INSERT INTO verification_code (idUser, codeverification) VALUES(?, ?)", [iduser, randomCode]);
    }
    });

    
}
function verifyUser(user, code, cb)
{
	pool.query("SELECT * FROM verification_code WHERE idUser = ? AND codeverification = ?", [user, code],
		function(err, result)
		{
			if (err) throw err;
			cb(result);
		}
	);
}
module.exports = {


  verify_user: (req, res, next) =>
{ 
	let user = req.body.user;
	let code = req.body.code;
	verifyUser(user, code, function(result)
	{
		let length = result.length;
		if (length == 0)
		{
			res.json({resp :"invalid"});
		}
		else
		{
			pool.query("DELETE FROM verification_code WHERE idUser = ?", [user]);
			pool.query("UPDATE user SET enabled = 1 WHERE id = ?", [user]);
			res.json({resp : "User updated"});
		}
	});
},

createUser: (req, res) => {
    

    let name = req.body.name;
    let email = req.body.email;
    let equipe = req.body.equipe;
    let password = req.body.password;
    pool.query("SELECT * FROM user WHERE email = ?", [email],
    function (err, result)
    {
        if (err) throw err;
        let numRows = result.length;
        if (numRows != 0)
        {
          return res.status(500).json({
            success:0,
            message:"database connexion error"
          });
            
        }
        else
        {
          password=md5(password);
          pool.query("insert into user(name,email,equipe,password) values(?,?,?,?)",
          [name,email,equipe,password],
          function(err2, result2)
          {
            if (err2) throw err2;
            let resultId = result2.insertId;
            sendVerificationEmail(email , resultId);
             res.json({resultId : String(resultId)});
            console.log("done!");
          });
        

        }
    });

  },

  
  getUserByUserId: (req, res) => {
    const id = req.params.id;
    getUserByUserId(id, (err, results) => {
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
      results.password = undefined;
      return res.json({
      results
      });
    });
  },
  getUsers: (req, res) => {
    getUsers((err, results) => {
      if (err) {
        console.log(err);
        return;
      }
      return res.json({
        data : results
      });
    });
  },
  updateUsers: (req, res) => {
    const body = req.body;
    body.password = md5(body.password, salt);
    updateUser(body, (err, results) => {
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
  deleteUser: (req, res) => {
    const data = req.body;
    deleteUser(data, (err, results) => {
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
        message: "user deleted successfully"
      });
    });
  },

  login: (req, res) => {
    const body = req.body;
    console.log("logging in ");
    getUserByUserEmail(body.email, (err, results) => {
     
	
	 
	 
      if (err) {
        console.log(err);
      }
      else if (!results) {
		  console.log("Invalid email");
		   var user = {
		id: -1,
		name: "aa",
		email:"a",
		equipe: "40",
		password: "dsdsadasdasdasdasdasasda"
	 };
         res.end(JSON.stringify(user));
      }
      
      else if (md5(req.body.password)==results.password) {
      //  var taken_password =rows[0].md5(req.body.password);
	  console.log(results);
        res.end(JSON.stringify(results));
      } 
      else{
		   var user = {
		id: -2,
		name: "aa",
		email:"a",
		equipe: "40",
		password: "dsdsadasdasdasdasdasasda"
	 };
		  console.log("Invalid password");
        res.end(JSON.stringify(user));  
      }
    });
  },



  loginFantazy: (req, res) => {
    const body = req.body;
    console.log("logging in ");
    getUserByUserEmailFantasy(body.email, (err, results) => {
     
      if (err) {
        console.log(err);
      }
      else if (!results) {
		   var club = {
		id: -2,
		email:"dsd",
		password:"dsa",
		name: "aa",
		price: 2.0,
		points: 55,
	    fixture: "dzd",
		userid: -1
	 };
         res.end(JSON.stringify(club));
      }
      
      else if (md5(req.body.password)==results.password) {
      //  var taken_password =rows[0].md5(req.body.password);
        res.end(JSON.stringify(results));
      } 
      else{
        var club = {
		id: -2,
		email:"dsd",
		password:"dsa",
		name: "aa",
		price: 2.0,
		points: 55,
	    fixture: "dzd",
		userid: -2
	 };
         res.end(JSON.stringify(club));
      }
    });
  },

  verifyEmailForReset: (req, res, next) =>
{ 
  let email = req.body.email;
  pool.query("SELECT id FROM user WHERE email = ? ", [email],
  function (err, result)
  {

      if (err) throw err;
      let numRows = result.length;
      if (numRows != 0)
      {
        let iduserr= result[0].id;
        
        console.log(iduserr,"this is shit");
        
        
        sendVerificationEmailForResetPass(email , iduserr);
         res.json({iduserr});
          console.log("done!");
        
      }
         
    });

  
 
 

 
	
}	,
verify_user_forReset: (req, res, next) =>
{ 
	let user = req.body.user;
	let code = req.body.code;
	verifyUser(user, code, function(result)
	{
		let length = result.length;
		if (length == 0)
		{
			res.json({resp :"invalid"});
		}
		else
		{
			pool.query("DELETE FROM verification_code WHERE idUser = ?", [user]);
			//pool.query("UPDATE user SET enable = 1 WHERE iduser = ?", [user]);
			res.json({resp : "code verifié"});
		}
	});
},
updatepassword: (req, res, next) =>
{ 
	let user = req.body.user;
  let password = req.body.password;
  let new_pass = md5(password);
  pool.query("DELETE FROM verification_code WHERE idUser = ?", [user]);
			pool.query("UPDATE user SET password = ? WHERE id = ?", [new_pass,user]);
			res.json({resp : "updated"});

	
},

};
