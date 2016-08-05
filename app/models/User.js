var lib = require('./../modules/lib');
var bcrypt = require('bcrypt-nodejs');
var md5 = require('md5');
var pg = require('pg');

/*
 * Object Constructor
 */
function User() {
    this.UserId =       -1;        
    this.Title=         '';    
    this.FirstName=     '';        
    this.Surname=       '';        
    this.Address1=      '';        
    this.Address2=      '';        
    this.Address3=      '';        
    this.City=          '';    
    this.County=        '';        
    this.Postcode=      '';        
    this.Username=      '';        
    this.Password=      '';        
    this.Email=         '';    
    this.Contact=       '';        
    this.DoB=           '';    
    this.Gender=        '';              
    this.Academia=      '';        
    this.Twitter=       '';        
    this.Website=       '';        
    this.DateCreated=   '';        
    this.Permissions=   '';        
    this.Activated=     '';        
    this.Banned=        '';
    // Additional
    this.Digest=        ''; //Digest of Email
}

/**
 * Hash password in pass property of object {o}
 * @param o Object
 */
User.prototype.hash = function (o) {
    var salt = bcrypt.genSaltSync(8);
    return bcrypt.hashSync(o.pass, salt)
};

/**
 * validate pass property of object {o}
 * against user password property
 * @param o Object
 * @param callback function(err, valid)
 */
User.prototype.validate = function (o, callback) {
    callback(bcrypt.compareSync(o.pass, User.Password));
};

User.prototype.findAll = function () {

};
User.prototype.findOne = function (o) {

};

/**
 * Find user in database with object from form {object}
 * populate object with user data for later interrogation
 * @param o Object
 * @param callback function(err, user)
 */
User.prototype.findUser = function (o, callback) {
    var error;
    var results = [];
    var query = {};

    if (o.user.contains('.ac.uk') || o.user.contains('.co.uk') || o.user.contains('.com') && o.user.contains('@')) {
        query = {
            text: 'SELECT * from "User" WHERE "EmailAddress"=$1',
            values: [o.user.toLowerCase()]
        }
    } else {
        query = {
            text: 'SELECT * from "User" WHERE LOWER("Username")=LOWER($1) LIMIT 1',
            values: [o.user]
        };
    }
    pg.connect(process.env.DATABASE_URL, function (err, client, done) {
        /* if Connection Callback Error */
        if (err) {
            console.log(err);
        }
        /* Client runs query */
        var q = client.query(query, function (err, result) {
            /* Client Q has error */
            if (err) throw err;
            else return result;
        });
        /* Client Q has row */
        q.on('row', function (row, result) {
            results.push(row);
            result.addRow(row);
        });
        /* Client Q has finished */
        q.on('end', function (result) {
            done();
            var found = false;
            if (result.rows[0] != undefined) {
                setResults(result);
                found = true;
                // TODO FIX DIGEST
                result.rows[0].Digest=User.Digest;
            }
            else found = false;
            // callback(error, result.rows[0], found);
            callback(error, result.rows[0], found);
        });
    });
};

/**
 * populate User object with query data {results}
 * @param results Object
 */
setResults = function (results) {
    set("UserId", results.rows[0].UserId);
    set("Title", results.rows[0].Title);
    set("FirstName", results.rows[0].FirstName);
    set("Surname", results.rows[0].Surname);
    set("Address1", results.rows[0].Address1);
    set("Address2", results.rows[0].Address2);
    set("Address3", results.rows[0].Address3);
    set("City", results.rows[0].City);
    set("County", results.rows[0].County);
    set("Postcode", results.rows[0].Postcode);
    set("Username", results.rows[0].Username);
    set("Password", results.rows[0].Password);
    set("Email", results.rows[0].Email);
    set("Contact", results.rows[0].Contact);
    set("DoB", results.rows[0].DateOfBirth);
    set("Gender", results.rows[0].Gender);
    set("Academia", results.rows[0].Academia);
    set("Twitter", results.rows[0].Twitter);
    set("Website", results.rows[0].Website);
    set("DateCreated", results.rows[0].DateCreated);
    set("Permission", results.rows[0].Role);
    set("Activated", results.rows[0].Activated);
    set("Banned", results.rows[0].Banned);
    // Others
    set("Digest", md5(results.rows[0].EmailAddress));
};

/**
 * Returns the data in
 * current instance of user
 */
User.prototype.getResults = function () {
    return User;
};
/**
 * find by Id function
 * TODO FINISH
 * @param o Object
 */
User.prototype.findbyId = function (id) {
    query = {
        text: 'SELECT * FROM "User" WHERE "UserId"=$1',
        values: [id]
    };
};
/**
 * find by {what} function
 * TODO FINISH
 * @param o Object
 */
User.prototype.find = function (where, op, what) {
    query = {
        text: 'SELECT * FROM "User" WHERE $1 $2 $3',
        values: [where, op, what]
    };
};

/**
 * sets {property} of user
 * to {values} provided
 * @param prop String
 * @param val Type
 */
function set(prop, val) {
    User[prop] = val;
}
/**
 * sets {property} of user
 * to {values} provided
 * @param prop String
 * @param val Type
 */
function setOther(prop, val) {
    this[prop] = val;
}

/**
 * gets {property} of user
 * to {values} provided
 * @param prop String
 */
function get(prop) {
    return User[prop];
}

/**
 * get {user} and populate object with user
 * for rendering of their profile
 * @param o Object
 */
User.prototype.getUser = function (o) {
    var results = [];
    var query = {
        text: 'SELECT * from "User" WHERE LOWER("Username")=LOWER($1) LIMIT 1',
        values: [o.user]
    };

    pg.connect(process.env.DATABASE_URL, function (err, client, done) {
        /* if Connection Callback Error */
        if (err) {
            console.log(err);
        }
        /* Client runs query */
        var q = client.query(query, function (err, result) {
            /* Client Q has error */
            if (err) throw err;
            else return result;
        });
        /* Client Q has row */
        q.on('row', function (row, result) {
            results.push(row);
            result.addRow(row);
        });
        /* Client Q has finished */
        q.on('end', function (result) {
            done();
            var found = false;
            if (lib.isset(result.rows[0])) {
                setResults(result);
                found = true;
            }
            else found = false;
            callback(error, found, result.rows[0]);
        });
    });
};

User.prototype.restify = function (res) {
    //TODO FIX
    var results = [];
    // set('Password', '');
    // delete User.Password;
    res.json(User);
};

module.exports = User;



// -- DDL
// CREATE TABLE "User"
// (
//     "UserId" INTEGER PRIMARY KEY NOT NULL,
//     "Title" VARCHAR(35),
//     "FirstName" VARCHAR(35) NOT NULL,
//     "Surname" VARCHAR(35) NOT NULL,
//     "Address1" VARCHAR(35) NOT NULL,
//     "Address2" VARCHAR(35),
//     "Address3" VARCHAR(35),
//     "City" VARCHAR(35) NOT NULL,
//     "County" VARCHAR(35) NOT NULL,
//     "Postcode" VARCHAR(8) NOT NULL,
//     "Username" VARCHAR(35) NOT NULL,
//     "Password" VARCHAR(63) NOT NULL,
//     "Email" VARCHAR(254) NOT NULL,
//     "Contact" CHAR(12),
//     "DoB" DATE NOT NULL,
//     "Gender" VARCHAR(14),
//     "Facebook" VARCHAR(254),
//     "Academia" VARCHAR(254),
//     "Twitter" VARCHAR(254),
//     "Website" VARCHAR(254),
//     "DateCreated" DATE DEFAULT now() NOT NULL,
//     "Permissions" INTEGER DEFAULT 3 NOT NULL,
//     "Activated" BOOLEAN DEFAULT true NOT NULL,
//     "Banned" BOOLEAN DEFAULT false NOT NULL
// );
// CREATE UNIQUE INDEX "U_Username" ON "User" ("Username");



// -- Login
// apiRouter.get('/user/:user', function (req, res) {
//     var results;
//     var o = {};
//     o.user = req.params.user;
//     var param = {};
//     param.pretty = false;

//     if (lib.isset(req.query)) {
//         param.pretty = req.query['pretty'];
//         param.pw=req.query['pw'];
//     }

//     var user = new User();
//     user.findUser(o, function (err, userData, found) {
//             if (found) {
//                 //TODO REMOVE WHEN TESTING DONE
//                 if (param.pw != config.secret) {
//                     delete userData.Password;
//                     console.log(user.Digest);
//                     /**
//                      * Trim whitespace
//                      */
//                     for (var key in userData) {
//                         if (lib.isset(userData[key]) && userData[key] != null) {
//                             if (userData[key].trim) {
//                                 userData[key] = userData[key].trim();
//                             }
//                         }
//                     }
//                     /**
//                      * Trim time off of date
//                      */
//                     userData.Created = userData.Created.toJSON();
//                     userData.DateOfBirth = userData.DateOfBirth.toJSON();
//                     if (userData.Created.contains('T')) {
//                         userData.Created = userData.Created.substring(0, 10);
//                         // console.log(userData.Created);
//                     }
//                     if (userData.DateOfBirth.contains('T')) {
//                         userData.DateOfBirth = userData.DateOfBirth.substring(0, 10);
//                     }
//                 }

//                 mod.returnJSON(res, userData, param);
//                 // user.restify(res);
//             }

//             else mod.returnJSON(res, results, param);
//             //TODO GRAVATAR
//             //Hash Email (MD5)
//             //e.g. http://1.gravatar.com/avatar/526ff9079f5c33b8b603abfedc823a0e?size=128
//         }
//     );
// });