var lib = require('./lib');
var pg = require('pg');

/**
 * Return for query {query} results {results} as {res} JSON (REST)
 * @param userId Int
 * @param action String
 */
function logdb(req, uid, sid, action) {
    if (!lib.isset(uid)) {
        uid = 0;
    }
    if (!lib.isset(action)) {
        action = 'Did something';
    }
    if(!lib.isset(sid)){
        sid = 'N/A';
    }
    query = {
        text: 'INSERT INTO public."Log" ("UserId", "SessionId", "Action", "Performed", "LogId", "Expiration","IP") VALUES ($1, $2, $3, DEFAULT, DEFAULT, DEFAULT, $4)',
        values: [uid, sid, action, req.connection.remoteAddress]
    };

    pg.connect(process.env.DATABASE_URL, function (err, client, done) {
        /* if Connection Callback Error */
        if (err) {
            console.log(err);
        }
        var q = client.query(query, function (err, result) {
            /* Client Q has error */
            if (err) console.log(err);
            return '';
        });
    });
}

exports.logdb = logdb;
