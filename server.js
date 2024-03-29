//  ==================== Modules ====================
const express = require('express');
const app = express();

var authRouter = express.Router();
// module.exports = authRouter;

var bodyParser = require('body-parser');
var cookieParser = require('cookie-parser');

var methodOverride = require('method-override');
var favicon = require('serve-favicon');

var morgan = require('morgan');

var subdomain = require('express-subdomain');
var pg = require('pg');

var path = require('path');
var fs = require('fs');

var session = require('express-session');
var pgStore = require('connect-pg-simple')(session);
var uuid = require('node-uuid');

var flash = require('connect-flash');


// TODO profile page
// TODO Restify User
// TODO
// TODO strip html
// TODO WHERE CURLY BRACE OMIT FROM SEARCH TEXT
// TODO Paginate results
// TODO Finish Filter
// TODO LOGIN
// TODO FIX XSS Vulnerabilities with server queries

if (process.env.NODE_ENV != "college") {
    var env = require('dotenv').config();
}

//  ===================== Config =====================
global.appRoot = path.resolve(__dirname);                          // Application Root for absolute paths
config = require('./app/config');                                  // Import Configs for easy editing.

// ====================== DB ======================
var client = new pg.Client(config.db.url);
client.connect(function (err) {
    if (err) console.log("Database Connection Error.");
    else console.log("Database Connection Successful.");
});
// ======================   Body  ======================
app.use(bodyParser.json());                                       // parse application/json
app.use(bodyParser.json({type: 'application/vnd.api+json'}));     // parse application/vnd.api+json as json
app.use(bodyParser.urlencoded({extended: true}));                 // parse application/x-www-form-urlencoded

// ======================   Sessions / Cookies  ======================
app.use(cookieParser());
app.use(session({
        genid: function (req) {
            return uuid();
        },
        secret: config.secret,
        proxy: true,
        resave: true,
        saveUninitialized: false, // Set to false for now, so only sessions with added data are saved;
        store: new pgStore(config.db.url),
        cookie: {/*secure:true, */maxAge: 1800000}
    })
);
app.use(flash());

// ======================  Method ======================
app.use(methodOverride('X-HTTP-Method-Override'));
app.use(favicon(config.dir.favicon + '/favicon.ico'));

// ======================  Logging, Debugging & Errors ======================
//app.use(morgan('dev'));                                             // Log HTTP Requests

// ======================  Dirs r ======================
app.set('view engine', 'jade');
app.use('/public', express.static(config.dir.public));
// app.use('/', express.static(config.dir.views));

// ====================== Routes ======================

//Back-End
var apiRouter = require('./app/routes/api')(express, client);
app.use('/api', apiRouter);
// app.use(subdomain('api', apiRouter));

//Front-End
var appRouter = require('./app/routes/view')(express, client);
app.use('/', appRouter);

// ====================== Listen ======================


console.log('Express listening on ' + config.port.default);
app.listen(config.port.default).on('error', function (err) {
    if (err) { // Try Alternate Port
        console.log('Error: ' + config.port.default + ' in use.');
        app.listen(config.port.alternate).on('error', function (err) {
            if (err) throw err;                                          // port 8080 and portAlt 3000 in use
        });
        console.log('Express listening on ' + config.port.alternate);
    }
});
console.log("App running in " + process.env.NODE_ENV + " mode");
exports = module.exports = app;
//TODO READ INTO 12FactorApp http://12factor.net/config
//TODO Change result query to get image ID. If 0, display No image assoc, else display Image