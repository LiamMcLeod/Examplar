var mod = require('../modules/rm');
var lib = require('../modules/lib');
var User = require('../models/User');
var lg = require('../modules/lg');
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
        var likeTerm = "%" + searchTerm + "%";
        var regexTerm = "(?!<[^>]*?>)(" + searchTerm + ")(?![^<]*?>)";
        var param = {};
        param.pretty = false;

        if (lib.isset(req.query)) {
            param.pretty = req.query['pretty'];
        }

        var query = {
            text: 'SELECT * FROM search WHERE "QuestionText" ~* $1 OR "ExamBoardName" ILIKE $2 OR "ExamPaperUnit" ILIKE $2 OR "LevelTitle"  ILIKE $2 OR "SubjectTitle"  ILIKE $2 ORDER BY "QuestionNumber"',
            values: [regexTerm, likeTerm]
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
     * /api+ TEST ROUTES
     * Hash Test
     */
    apiRouter.get('/hash', function (req, res) {
        // res.send('Hello World');
        if (lib.isset(req.query['pw'])) {
            var user = new User();
            var o = {};
            o.pass = req.query['pw'];
            mod.returnJSON(res, user.hash(o), req.query);
        }
        else
            res.send('no pw parameter.')
    });
    /**
     * GET
     * /api+ TEST ROUTES
     * IP Test
     */
    apiRouter.get('/ip', function (req, res) {
        var ip = req.connection.remoteAddress;
        var test = ip.substring(0, 7);
        if (test === '::ffff:')
            mod.returnJSON(res, ip.substring(7, ip.length), req.query);
        else
            ip = req.connection.remoteAddress;
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
            param.pw = req.query['pw'];
        }

        var user = new User();
        user.findUser(o, function (err, user, found) {
                if (found) {
                    //TODO MESS WITH THE DATES SO THEY DISPLAY IN UK
                    //TODO REMOVE WHEN TESTING DONE
                    if (param.pw != config.secret) {
                        delete user.Password;
                        /**
                         * Trim whitespace
                         */
                        for (var key in user) {
                            if (lib.isset(user[key]) && user[key] != null) {
                                if (user[key].trim) {
                                    user[key] = user[key].trim();
                                }
                            }
                        }
                        /**
                         * Trim time off of date
                         */
                        //TODO FIX THIS
                        user.DateCreated = user.DateCreated.toJSON();
                        user.DoB = user.DoB.toJSON();
                        if (user.DateCreated.contains('T')) {
                            user.DateCreated = user.DateCreated.substring(0, 10);
                            // console.log(userData.Created);
                        }
                        if (user.DoB.contains('T')) {
                            user.DoB = user.DoB.substring(0, 10);
                        }
                    }
                    mod.returnJSON(res, user, param);
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
        user.findUser(o, function (err, user, found) {
            if (err) throw err;
            lg.logdb(req, 0, req.session.id, "A user attempted to log in as " + o.user);
            if (found) {
                /**
                 * Validate password with data posted
                 * against data in the user model.
                 */
                user.validate(o, function (valid) {
                    if (valid) {
                        //TODO LOG THIS
                        lg.logdb(req, 0, req.session.id, "A user validated as " + o.user);
                        /**
                         * Trim whitespace
                         */
                        for (var key in user) {
                            if (lib.isset(user[key]) && user[key] != null) {
                                if (user[key].trim) {
                                    user[key] = user[key].trim();
                                }
                            }
                        }
                        if (user.Banned) {
                            req.session.loggedIn = false;
                            lg.logdb(req, user.UserId, req.session.id, "A user logged in as " + o.user + " but is banned");
                            req.session.destroy();
                            req.flash('status', 'You have been banned.');
                            res.redirect(303, '/user');
                        }
                        if (!user.Activated) {
                            req.session.loggedIn = false;
                            lg.logdb(req, user.UserId, req.session.id, "A user logged in as " + o.user + " but the account is inactive");
                            req.session.destroy();
                            req.flash('status', 'Your account is not yet active.');
                            res.redirect(303, '/user');
                        }
                        /**
                         * Trim time off of date
                         */
                        user.DateCreated = user.DateCreated.toString();
                        user.DoB = user.DoB.toString();
                        /**
                         * Populate session var
                         */
                        req.session.loggedIn = true;
                        req.session.user = user;
                        req.flash('status', 'Success!');
                        if (req.session.loggedIn) {
                            lg.logdb(req, user.UserId, req.session.id, "A user logged in as " + o.user);
                        }
                        res.redirect(302, '/user');
                    } else {
                        /**
                         * Notify user incorrect password
                         */
                        req.session.loggedIn = false;
                        lg.logdb(req, 0, req.session.id, "User entered the wrong password for." + o.user)
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