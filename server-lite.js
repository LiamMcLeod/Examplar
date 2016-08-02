//  ==================== Modules ====================
const express = require('express');
const app = express();

var authRouter = express.Router();
module.exports = authRouter;

var bodyParser = require('body-parser');

var methodOverride = require('method-override');
var favicon = require('serve-favicon');

var morgan = require('morgan');

var pg = require('pg');

var path = require('path');
var fs = require('fs');

//Uncomment when not a college
//if (!process.env.NODE_ENV) {
//    var env = require('dotenv').config();
//}


//  ===================== Config =====================                           // Import Configs for easy editing.
// Application Root for absolute paths
global.appRoot = path.resolve(__dirname);
config = require('./app/config');

// ====================== DB ======================
var client = new pg.Client(config.db.url);

client.connect(function (err) {
    if (err) console.log("Database Connection Error.");
    else console.log("Database Connection Successful.");
});
// ======================   Body  ======================
app.use(bodyParser.json());                                         // parse application/json
app.use(bodyParser.json({type: 'application/vnd.api+json'}));     // parse application/vnd.api+json as json
app.use(bodyParser.urlencoded({extended: true}));                 // parse application/x-www-form-urlencoded


// ======================  Method ======================
app.use(methodOverride('X-HTTP-Method-Override'));
app.use(favicon(config.dir.favicon + '/favicon.ico'));

// ======================  Logging, Debugging & Errors =============
app.use(morgan('dev'));                                             // Log HTTP Requests

// ======================  Dirs  ======================
app.set('view engine', 'jade');
app.use('/public', express.static(config.dir.public));

// ====================== Routes ======================#
var mod = require('./app/modules/rm');
var lib = require('./app/modules/lib');
app.get('/:file', function (req, res) {
    var file = req.params.file;
    mod.renderFile(req, res, file);
});
app.get('/api/search/:term', function (req, res) {
    var searchTerm = req.params.term;
    var param = {};
    param.pretty = false;

    if (lib.isset(req.query)) {
        param.pretty = req.query['pretty'];
    }
    var likeTerm = "%" + searchTerm + "%";

    var query = {
        text: 'SELECT * FROM search WHERE "QuestionText" ~* \'(?!<[^>]*?>)($1)(?![^<]*?>)\' OR "ExamBoardName" ILIKE \'%$2%\' OR "ExamPaperUnit" ILIKE \'%$2%\' OR "LevelTitle"  ILIKE \'%$2%\' OR "SubjectTitle"  ILIKE \'%$2%\' ORDER BY "QuestionNumber"',
        values: [searchTerm, likeTerm]
    };
    var q = client.query(query, function (err, result) {
    });
    mod.getResults(res, q, param);
});
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
