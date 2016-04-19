var mod = require('../modules/routeModules');
var lib = require('../modules/lib');
var User = require('../models/User');

module.exports = function (express) {
    var appRouter = express.Router();

    /**
     * GET
     * '/'
     * Deliver's index with random background
     * TODO Parse session data into index
     */
    appRouter.get('/', function (req, res) {
        var $ = req.session;

        var file = "index";
        if ($.loggedIn) {
            mod.renderLoggedIn(req, res, file);
        }
        else {
            mod.renderLoggedOut(req, res, file);
        }
    });

    /**
     * GET
     * ''
     * Deliver's index with random background
     * TODO Parse session data into index
     */
    appRouter.get('', function (req, res) {
        var $ = req.session;
        var file = "index";
        if ($.loggedIn) {
            mod.renderLoggedIn(req, res, file);
        }
        else {
            mod.renderLoggedOut(req, res, file);
        }
    });

    /**
     * GET
     * '/'
     * Deliver's index with random background
     * TODO Parse session data into index
     */
    appRouter.get('/debug', function (req, res) {

        var getReq = req.query['q'];
        // console.log(getReq);

        res.render('debug.jade', {
            getReq: getReq
        });

    });

    // File Routes
    // File called with no extension

    /**
     * GET
     * '/u/'+username
     * User profile page
     * //TODO generate from restful api
     */
    appRouter.get('/u/:id', function (req, res) {
        var o = {};
        o.user = req.params.id;
        var $ = req.session;

        if (o.user && $.loggedIn) {
            var user = new User();
            user.findUser(o, function (err, user) {
                delete user.password;
                req.session.profile = user;
                mod.renderProfile(req, res);
            });
        }
        else if (!o.user && $.loggedIn) {
            req.session.profile = req.session.user;
            mod.renderProfile(req, res);
        }
        else {
            res.render('profile', {
                bg: lib.rnd(),
                status: $.status,
                loggedIn: $.loggedIn
            }, function (err, result) {
                if (err) mod.error(req, res, err);
                else res.send(result)
            });
        }
    });

    appRouter.get('/:file', function (req, res) {
        //TODO q doesn't work on / ONLY index
        var $ = req.session;
        var file = req.params.file;

        if ($.user) {
            if ($.user.Created.contains('T')) {
                $.user.Created = $.user.Created.substring(4, 15);
                // console.log($.user.Created);
            }
            if ($.user.DateOfBirth.contains('T')) {
                $.user.DateOfBirth = $.user.DateOfBirth.substring(4, 15);
                // console.log($.user.DateOfBirth);
            }
        }

        if ($.loggedIn) {
            mod.renderLoggedIn(req, res, file);
        }
        else {
            mod.renderLoggedOut(req, res, file);
        }

    });

    return appRouter;
};
