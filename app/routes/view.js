var mod = require('../modules/routeModules');
var lib = require('../modules/lib');
var User = require('../models/User');

module.exports = function (express) {
    var appRouter = express.Router();

    /*
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

    /*
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

    /*
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

        // var getReq = '', idReq = '';
        // if (file === "home" || file === "Home" || file == "index" || file === "index") {
        //     file = "index";
        //     if (req.query != []) {
        //         getReq = req.query['q'];
        //     }
        //     res.render(file, {
        //         getReq: getReq
        //     }, function (err, result) {
        //         if (err) mod.error(req, res, err);
        //         else res.send(result); // send rendered HTML back to client
        //     });
        // }
        // if (file === "result") {
        //     idReq = req.query['id'];
        //     res.render(file, {
        //         idReq: idReq
        //     }, function (err, result) {
        //         if (err) mod.error(req, res, err);
        //         else res.send(result); // send rendered HTML back to client
        //     });
        // }
        // else {
        //     console.log(file);
        //     res.render(file, {}, function (err, result) {
        //         if (err) {
        //             mod.error(req, res, err);
        //         }
        //         else res.send(result); // send rendered HTML back to client
        //     });
        // }
    });

    return appRouter;
};
