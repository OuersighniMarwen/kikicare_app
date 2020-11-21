var mysql= require('mysql');
var express=require('express');

var multer = require('multer');

const app=express();
const port=1225;

var con=mysql.createConnection({
	host:"localhost",
	user:"root",
	password:"",
	database:"kikicare_bd"
});




const storage = multer.diskStorage(
  {
    destination :function(req ,file,cb){
      
      cb(null, './images/');
    },
    filename :function(req,file,cb){
  
      cb(null, file.originalname);
    }
  }
); 

const upload = multer({storage:storage})
/* GET users listing. */
//router.post('/', upload.single('picture'), controller.create)

app.get('/', (req, res) => {
res.send("Serveur KiKiCare");
	});


app.get('/signup', function (req, res) {
  var first_name = req.query.first_name;
  var last_name = req.query.last_name;
  var email = req.query.email;
  var password = req.query.password;
  var num_tel = req.query.num_tel;
  var adress = req.query.adress;
  var url_image = req.file.path;
  var mode_cnx = req.query.mode_cnx;
  var sql = "INSERT INTO USERS (first_name, last_name, email, password, num_tel, adress, url_image, mode_cnx) VALUES('" + first_name + "' , '" + last_name + "' , '" + email + "',  '" + password + "', '" + num_tel + "', '" + adress + "', '" + url_image + "', '" + mode_cnx + "')";
  con.query(sql, function (err, result) {
    if(err) throw err;
    console.log(err);
  	console.log("user " + email + "added !");
  });
  res.statusCode = 200;
  res.setHeader('Content-Type', 'text/plain');
  res.send("user " + email + " added !");
});

app.get('/getAnimalsByUser', function (req, res) {
  var sql = "SELECT * FROM ANIMALS WHERE id_user LIKE '" + req.query.id_user + "'";
  	con.query(sql, function (err, result) {
  		if(err) throw err;
  		res.json(result);
			console.log("get animals of user " + req.query.id_user);
  	});
});

app.get('/getUser', function (req, res) {
  var sql = "SELECT * FROM USERS WHERE EMAIL LIKE '" + req.query.email + "'";
  con.query(sql, function (err, result) {
  	if(err) throw err;
  	res.json(result[0]);
		console.log("login user " + req.query.email);
  });
});

app.get('/login',(req,res,next)=>{

  var sql = "SELECT * FROM USERS WHERE EMAIL LIKE '" + req.query.email + "' AND PASSWORD LIKE '" + req.query.password + "'";

  con.query(sql, function (err, result) {
      if(err) throw err;
      res.json(result[0]);
      console.log("get user " + req.query.email);
  });

});


app.get('/getAllAnimals/',(req,res,next)=>{
   

  con.query('SELECT * FROM ANIMALS',function (err,result,fields) 
  {
      con.on('error', function (err) {
          console.log('[MYSQL ERROR]', err);
      });
      if (result && result.length)

          res.end(JSON.stringify(result))

  });

})


/*var multer = require('multer');
var upload_image = multer({dest:'images'});

app.use(express.static('public'));

//Serves all the request which includes /images in the url from Images folder
app.use('/images', express.static(__dirname + '/images'));

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));


app.post('/upload_image', upload_image.single('url_image'), (req, res) => {
  try {
    res.send(req.file);
  }catch(err) {
    res.send(400);
  }
});  */


/*

app.post('/UpdateUser', function (req, res) {
  var first_name = req.query.first_name;
  var last_name = req.query.last_name;
  var email = req.query.email;
  var password = req.query.password;
  var url_image = req.query.url_image;
  var sql = "UPDATE USER SET email = '"+ email +"', first_name = '"+ first_name +"', last_name = '"+ last_name +"', password = '"+ password +"', url_image = '"+ url_image +"' WHERE email LIKE '"+ email +"'";
  con.query(sql, function (err, result) {
    if(err) throw err;
  	console.log("user " + email + "updated !");
  });
  res.statusCode = 200;
  res.setHeader('Content-Type', 'text/plain');
  res.send("user " + email + " updated !");
});



app.post('/AddAnimal', function (req, res) {
  var name = req.query.name;
  var id_user = req.query.id_user;
  var sexe = req.query.sexe;
  var type = req.query.type;
  var image = req.query.image;
  var date_nais = req.query.date_nais;
  var race = req.query.race;
  var size = req.query.size;
  var sql = "INSERT INTO ANIMAL (id_user, name, sexe, type, date_nais, race,size,image ) VALUES('" + id_user + "', '" + name + "' , '" + sexe+ "', '" + type + "', '" + date_nais + "', '" + race +"', '" + size +"', '" + image + "')";
  con.query(sql, function (err, result) {
    if(err) throw err;
  	console.log("animal " + name + "added !");
  });
  res.statusCode = 200;
  res.setHeader('Content-Type', 'text/plain');
  res.send("animal " + name + " added !");

});

app.get('/getAnimal', function (req, res) {
  var sql = "SELECT * FROM ANIMAL WHERE NAME LIKE '" + req.query.name + "'";
  	con.query(sql, function (err, result) {
  		if(err) throw err;
  		res.json(result[0]);
			console.log("get " + req.query.name);
  	});
});

app.get('/getAnimalsByUser', function (req, res) {
  var sql = "SELECT * FROM ANIMAL WHERE for_adoption= 0 and id_user ='" + req.query.id_user + "'";
  	con.query(sql, function (err, result) {
  		if(err) throw err;
  		res.json(result);
			console.log("get " + req.query.id_user);
  	});
});

app.delete('/deleteAnimal', function (req, res) {
  var sql = "DELETE FROM ANIMAL WHERE id='" + req.query.id + "'";

  con.query(sql, function (err, result) {
    if(err) throw err;
  	console.log("animal " + req.query.id+ "deleted!");
  });
  res.statusCode = 200;
  res.setHeader('Content-Type', 'text/plain');
  res.send("animal " + req.query.id+ "deleted!");

});

*/

////////////////////////////////////////////////////////////////////////
/*
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
//app.use(cookieParser());
app.use(express.static( 'uploads'));

var bodyParser = require('body-parser');
app.use(bodyParser.json({limit: '50mb'}));
app.use(bodyParser.urlencoded({limit: '50mb', extended: true}));
*/
/////////////////////////////////////////////////////////////////////////



app.listen(port, () => console.log("serveur listening on : " + port));
