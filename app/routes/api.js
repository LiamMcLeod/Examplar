var mod = require('../modules/routeModules');
var lib = require('../modules/lib');
var User = require('../models/User');
// DEBUG STRING     console.log(req.method +" " + req.url + " from address " + req.connection.remoteAddress);

module.exports = function (express, client) {

    var apiRouter = express.Router();


    /**
     * GET
     * /api+'/'
     * Returns API version and other data
     */
    apiRouter.get('/', function (req, res) {
        var param = mod.checkParams(req, res);
        var results = {
            title: "API Version 0.0.1",
            properties: {options: "/user"}
        };
        mod.returnJSON(res, results, param);
    });

    /*
     *		Search Results			*
     ************************/
    apiRouter.get('/search/:term', function (req, res) {
        var searchTerm = req.params.term;
        var param = {};
        param.pretty = false;

        if (lib.isset(req.query)) {
            param.pretty = req.query['pretty'];
        }
        var likeTerm = "%" + searchTerm + "%";
        /*
        *TODO LOOK INTO FULL TEXT SEARCH SOLUTION
        * http://rachbelaid.com/postgres-full-text-search-is-good-enough/
        * http://shisaa.jp/postset/postgresql-full-text-search-part-1.html
        * https://www.google.co.uk/search?q=postgres+full+text+search+tutorial&oq=postgres+full+text+search+&aqs=chrome.2.69i57j69i60j0l4.7364j0j4&sourceid=chrome&ie=UTF-8
        *
        * OLD VERSION
        * SELECT * FROM search WHERE "QuestionText" ILIKE $1
        *
        * TEMP VERSION
        * text: 'SELECT * FROM search WHERE "QuestionText" ILIKE $1 OR "ExamBoardName" ILIKE $1 OR   "ExamPaperUnit" ILIKE $1 OR "LevelTitle"  ILIKE $1 OR "SubjectTitle"  ILIKE $1 ORDER BY "QuestionNumber"',
        *
        * NEW VERSION
        *
        *
        * TODO
        * FIX PROBLEM IN CORE THAT IS FILTERING RESULTS WHERE NOT CONTAINED IN QUESTIONTEXT
        * EMBOLDEN HYPERLINK {IF} THAT COLUMN HAS BEEN SEARCHED
        */
        var query = {
            text: 'SELECT * FROM search WHERE "QuestionText" ILIKE $1 OR "ExamBoardName" ILIKE $1 OR   "ExamPaperUnit" ILIKE $1 OR "LevelTitle"  ILIKE $1 OR "SubjectTitle"  ILIKE $1 ORDER BY "QuestionNumber"',
            values: [likeTerm]
        };
        var q = client.query(query, function (err, result) {
        });
        mod.getResults(res, q, param);
    });

       apiRouter.get('/match/:term', function (req, res) {
        var searchTerm = req.params.term;
        var param = {};
        param.pretty = false;

        if (lib.isset(req.query)) {
            param.pretty = req.query['pretty'];
        }
        var likeTerm = "%" + searchTerm + "%";
        var query = {
            text: 'SELECT * FROM search WHERE "QuestionText" @@ $1 ORDER BY "QuestionNumber"',
            values: [likeTerm]
        };
        var q = client.query(query, function (err, result) {
        });
        mod.getResults(res, q, param);
    });

    /*
     *		Results Page			*
     ************************/
    apiRouter.get('/result/:id', function (req, res) {
        var param = {};
        param.pretty = false;

        if (lib.isset(req.query)) {
            param.pretty = req.query['pretty'];
        }

        var results = [];
        var result = req.params.id;
        var query = {
            text: 'SELECT "Question"."QuestionId", "Question"."ExaminerId", "Question"."ExamPaperId", "Topic"."TopicId", "QuestionNumber", "QuestionText", "QuestionMarks", "QuestionMarkText", "ExamPaperUnit", "ExamPaperSeason", "ExamPaperDate", "ExamBoardName", "LevelTitle", "SubjectTitle", "TopicTitle", "ExaminerNote", "QuestionImageData", "Question"."QuestionImageId" FROM "Question" INNER JOIN "ExamPaper" ON "Question"."ExamPaperId" = "ExamPaper"."ExamPaperId" INNER JOIN "ExamBoard" ON "ExamPaper"."ExamBoardId" = "ExamBoard"."ExamBoardId" INNER JOIN "Level" ON "ExamPaper"."LevelId" = "Level"."LevelId" INNER JOIN "Subject" ON "ExamPaper"."SubjectId" = "Subject"."SubjectId" INNER JOIN "Examiner" ON "Question"."ExaminerId"="Examiner"."ExaminerId" INNER JOIN "QuestionImage" ON "Question"."QuestionImageId"= "QuestionImage"."QuestionImageId" INNER JOIN "QuestionTopic" ON "Question"."QuestionId" = "QuestionTopic"."QuestionId" INNER JOIN "Topic" ON "QuestionTopic"."TopicId"= "Topic"."TopicId" WHERE "Question"."QuestionId"=$1',
            values: [result]
        };

        //TODO RESULT WONT WORK WITHOUT IMAGE

        var q = client.query(query, function (err, result) {
        });

        q.on('row', function (row, res) {
            var b = new Buffer(row.QuestionImageData);
            row.QuestionImageData = b.toString();
            results.push(row);
        });
        q.on('end', function () {
            mod.returnJSON(res, results, param);
        })
    });

    /*
     *		More From		*
     ************************/
    apiRouter.get('/more/:id', function (req, res) {
        var param = {};
        param.pretty = false;

        if (req.query != null) {
            param.pretty = req.query['pretty'];
            param.qId = req.query['qId'];
        }

        var results = [];
        var result = req.params.id;
        var query = {
            text: 'SELECT "Question"."QuestionId", "QuestionNumber", "QuestionText", "Topic"."TopicId", "Question"."ExamPaperId" FROM "Question" INNER JOIN "ExamPaper" ON "Question"."ExamPaperId"="ExamPaper"."ExamPaperId" INNER JOIN "QuestionTopic" ON "Question"."QuestionId" = "QuestionTopic"."QuestionId" INNER JOIN "Topic" ON "QuestionTopic"."TopicId"= "Topic"."TopicId" WHERE "ExamPaper"."ExamPaperId"=$1 AND "Question"."QuestionId"!=$2 ORDER BY RANDOM() LIMIT 5',
            values: [result, param.qId]
        };

        var q = client.query(query, function (err, result) {
        });

        mod.getResults(res, q, param);
    });
    /*
     *		Questions Like		*
     ************************/
    apiRouter.get('/related/:id', function (req, res) {
        var param = {};
        param.pretty = false;

        if (req.query != null) {
            param.pretty = req.query['pretty'];
            param.qId = req.query['qId'];
        }

        var results = [];
        var result = req.params.id;
        var query = {
            text: 'SELECT "Question"."QuestionId", "QuestionNumber", "QuestionText", "Topic"."TopicId", "Question"."ExamPaperId", "ExamPaperUnit", "ExamPaperSeason", "ExamPaperDate" FROM "Question" INNER JOIN "ExamPaper" ON "Question"."ExamPaperId"="ExamPaper"."ExamPaperId" INNER JOIN "QuestionTopic" ON "Question"."QuestionId" = "QuestionTopic"."QuestionId" INNER JOIN "Topic" ON "QuestionTopic"."TopicId"= "Topic"."TopicId" WHERE "Topic"."TopicId"=$1 AND "Question"."QuestionId"!=$2 ORDER BY RANDOM() LIMIT 5',
            values: [result, param.qId]
        };
        var q = client.query(query, function (err, result) {
        });

        mod.getResults(res, q, param);

    });

    /*
     *		Get Image		*
     ************************/
    apiRouter.get('/image/:id', function (req, res) {
        var param = {};
        param.pretty = false;

        if (req.query != null) {
            param.pretty = req.query['pretty'];
        }

        var results = [];
        var id = req.params.id;

        var query = {
            text: 'SELECT "QuestionId", "Question"."QuestionImageId", "QuestionImageData" FROM "Question" INNER JOIN "QuestionImage" ON "Question"."QuestionImageId"= "QuestionImage"."QuestionImageId" WHERE "QuestionId"=$1',
            values: [id]
        };

        var q = client.query(query, function (err, result) {

        });

        q.on('row', function (row, res) {
            var b = new Buffer(row.QuestionImageData);
            row.QuestionImageData = b.toString();
            results.push(row);
        });
        q.on('end', function () {
            mod.returnJSON(res, results, param);
        })
    });
    /*
     *		Examiner Notes		*
     ************************/
    //TODO MOD QUERY TO DISPLAY QUESTION DATA
    apiRouter.get('/examiner/:id', function (req, res) {
        var param = {};
        param.pretty = false;

        if (req.query != null) {
            param.pretty = req.query['pretty'];
        }

        var results = [];
        var id = req.params.id;

        var query = {
            text: 'SELECT "ExaminerId", "ExaminerNote", "QuestionNo" FROM "Examiner" WHERE "ExaminerId"=$1 ',
            values: [id]
        };

        var q = client.query(query, function (err, result) {
        });
        mod.getResults(res, q, param);

    });

    /*
     *		Get SubjectList		*
     ************************/
    apiRouter.get('/filter/subject/', function (req, res) {
        var param = {};
        var results = [];

        param.pretty = false;
        if (req.query != null) {
            param.pretty = req.query['pretty'];
        }

        var query = {
            text: 'SELECT * FROM "Subject"'
        };

        var q = client.query(query, function (err, result) {
        });
        mod.getResults(res, q, param);
    });
    apiRouter.get('/filter/level/', function (req, res) {
        var param = {};
        var results = [];

        param.pretty = false;
        if (req.query != null) {
            param.pretty = req.query['pretty'];
        }

        var query = {
            text: 'SELECT * FROM "Level"'
        };

        var q = client.query(query, function (err, result) {
        });
        mod.getResults(res, q, param);
    });
    apiRouter.get('/filter/examboard/', function (req, res) {
        var param = {};
        var results = [];

        param.pretty = false;
        if (req.query != null) {
            param.pretty = req.query['pretty'];
        }

        var query = {
            text: 'SELECT * FROM "ExamBoard"'
        };

        var q = client.query(query, function (err, result) {
        });
        mod.getResults(res, q, param);
    });


    /**
     * GET
     * /api+ TEST ROUTES
     * Cookie Test
     */
    apiRouter.get('/cookie', function (req, res) {
        res.cookie('connect.sid', {MaxAge: 604800000}).send('Cookie is set');
    });


    /**
     * GET
     * /api+'/user'
     * Returns User JSON DATA
     *  TODO Finish or scrap
     *  RESTFUL Profile Generation?
     */
    apiRouter.get('/user/:user', function (req, res) {
        var results;
        var o = {};
        o.user = req.params.user;
        var param = {};
        param.pretty = false;

        if (lib.isset(req.query)) {
            param.pretty = req.query['pretty'];
        }

        var user = new User();
        user.findUser(o, function (err, userData, found) {
                if (found) {
                    delete userData.Password;
                    console.log(user.Digest);
                    /**
                     * Trim whitespace
                     */
                    for (var key in userData) {
                        if (lib.isset(userData[key]) && userData[key] != null) {
                            if (userData[key].trim) {
                                userData[key] = userData[key].trim();
                            }
                        }
                    }
                    /**
                     * Trim time off of date
                     */
                    userData.Created = userData.Created.toJSON();
                    userData.DateOfBirth = userData.DateOfBirth.toJSON();
                    if (userData.Created.contains('T')) {
                        userData.Created = userData.Created.substring(0, 10);
                        // console.log(userData.Created);
                    }
                    if (userData.DateOfBirth.contains('T')) {
                        userData.DateOfBirth = userData.DateOfBirth.substring(0, 10);
                    }
                    mod.returnJSON(res, userData, param);
                    // user.restify(res);
                }
                else mod.returnJSON(res, results, param);
                //TODO GRAVATAR
                //Hash Email (MD5)
                //e.g. http://1.gravatar.com/avatar/526ff9079f5c33b8b603abfedc823a0e?size=128
            }
        );
    });

    /**
     * GET
     * /api+'/logout'
     * Destroys user session data
     * Redirects them to index
     */
    apiRouter.get('/logout', function (req, res) {
        req.session.destroy();
        //TODO Cookie stuff
        // res.clearCookie('connect.sid');
        res.redirect('/', 303, function (err) {
            if (err) mod.error(req, res, err);
        })
    });

    /**
     * POST
     * /api+'/login'
     * Instantiates user to interrogate database
     * verifying credentials provided
     */
    apiRouter.post('/login', function (req, res) {
        //TODO Server Side Validation
        var user = new User();
        var o = {};
        //TODO logic for checkbox
        if (!req.body.username || typeof req.body.username === 'undefined' || req.body.username === null || req.body.username === '') {
            req.session.loggedIn = false;
            req.flash('status', 'Username empty.');
            res.redirect(303, '/user');
        } else {
            o.user = req.body.username;
        }
        if (!req.body.password || typeof req.body.password === 'undefined' || req.body.password === null || req.body.password === '') {
            req.session.loggedIn = false;
            req.flash('status', 'Password empty.');
            res.redirect(303, '/user');
        }
        else {
            o.pass = req.body.password;
        }

        /**
         * Calls to User model, providing data posted by
         * the user returns a boolean for if existing.
         * Populating the model.
         */
        user.findUser(o, function (err, userData, found) {
            if (err) throw err;
            if (found) {
                /**
                 * Validate password with data posted
                 * against data in the user model.
                 */
                user.validate(o, function (valid) {
                    if (valid) {
                        var obj = {};
                        /**
                         * Trim whitespace
                         */
                        for (var key in userData) {
                            if (lib.isset(userData[key]) && userData[key] != null) {
                                if (userData[key].trim) {
                                    userData[key] = userData[key].trim();
                                }
                            }
                        }
                        /**
                         * Trim time off of date
                         */
                        userData.Created = userData.Created.toString();
                        userData.DateOfBirth = userData.DateOfBirth.toString();
                        /**
                         * Populate session var
                         */
                        req.session.loggedIn = true;
                        req.session.user = userData;
                        req.flash('status', 'Success!');
                        res.redirect(302, '/user');
                    } else {
                        /**
                         * Notify user incorrect password
                         */
                        req.session.loggedIn = false;
                        req.flash('status', 'Incorrect password.');
                        res.redirect(303, '/user');
                    }
                })
            }
            else {
                /**
                 * Notify user incorrect username
                 */
                req.session.loggedIn = false;
                req.flash('status', 'Incorrect username.');
                res.redirect(303, '/user');
            }
        });
    });

    /**
     * POST
     * /api+'/edit/user'
     * Retrieves and changes made to user data
     */
    apiRouter.post('/edit/user', function (req, res) {
        //TODO Finish this route
        //TODO Server side validation for data and user role.
        var o = req.body();
        req.send(o)
    });

    /**
     * GET
     * /api+'/*'
     * Catch all 404 fallback
     */
    apiRouter.get('/*', function (req, res) {
        mod.returnJSON(res);
    });

    return apiRouter;
};
