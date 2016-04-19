String.prototype.contains = function (it) {
    return this.indexOf(it) != -1;
};
Array.prototype.isEmpty = function () {
    if (this.length === 0) {
        return true;
    } else {
        return false;
    }
};
function updateString(input, term) {
    return input.replace(new RegExp('(^|\)(' + term + ')(\|$)', 'ig'), '$1<strong>$2</strong>$3');
}
function dateToYear(y) {
    return y.substring(0, 4);
}
function shortenString(x) {
    if (x.length > 120 && x.charAt(119) != "?") {
        x = x.substring(0, 120);
        x += "..."
    }
    return x
}
function isInt(x) {
    return !isNaN(x) &&
        parseInt(Number(x)) == x && !isNaN(parseInt(x, 10));
}
function removeTags(x) {
    return x.replace(/<(?:.|\n)*?>/gm, '');
}
function escapeSquare(x) {
    x = x.replace(new RegExp('\\['), '\\[');
    x = x.replace(new RegExp('\\]'), '\\]');
    return x;
}

var prof;
prof = new Vue({

    // Element
    el: '#wrapper',

    data: {
        username: '',
        digest: '',
        email: '',
        created: '',
        firstName: '',
        lastName: '',
        title: '',
        doB: '',
        role: ''
    },

    route: {},

    ready: function () {

    },

    methods: {
        fetchUser: function(){

        },
        /************************
         *        Results Page    *
         ************************/
        fetchProfile: function (id) {
            // TODO IF ID NOT INT
            if (!isInt(id)) {
                return
            }
            this.$set('results', []);               //Purge results
            this.$set('related', []);
            this.$set('more', []);

            this.$http.get('/api/user/' + user)
                .then(function (res) {
                    if (!res.data.isEmpty()) {
                        this.$set('result', true)
                    }
                    var y = res.data[0].ExamPaperDate;
                    y = dateToYear(y);
                    res.data[0].ExamPaperDate = y;
                    topicId = res.data[0].TopicId;
                    examId = res.data[0].ExamPaperId;
                    //TODO ADJUST QUERY FOR IMAGE ID
                    if (res.data[0].QuestionImageId != 0) {
                        this.$set('hasImage', true);
                    }
                    this.$set('results', res.data[0]);
                    // Others
                    this.$http.get('/api/related/' + topicId + '?qId=' + id)
                        .then(function (res) {
                            var related = [];
                            for (var i = 0; i < res.data.length; i++) {
                                var y = res.data[i].ExamPaperDate;
                                y = dateToYear(y);
                                res.data[i].ExamPaperDate = y;
                                var x = res.data[i].QuestionText;
                                x = removeTags(x);
                                x = shortenString(x);
                                res.data[i].QuestionText = x;
                                this.$set('related[' + i + ']', res.data[i]);
                            }
                        })
                        .catch(function (err) {
                            console.log("Error: " + err);
                            throw err;
                        });
                    this.$http.get('/api/more/' + examId + '?qId=' + id)
                        .then(function (res) {
                            var more = [];
                            for (var i = 0; i < res.data.length; i++) {
                                var x = res.data[i].QuestionText;
                                x = removeTags(x);
                                x = shortenString(x);
                                res.data[i].QuestionText = x;
                                this.$set('more[' + i + ']', res.data[i]);
                            }
                        })
                        .catch(function (err) {
                            console.log("Error: " + err);
                            throw err;
                        });
                })
                .catch(function (err) {
                    console.log("Error: " + err);
                    throw err;
                });
        },
        /************************
         *        Fetch ExamNote    *
         ************************/
        fetchExamNote: function (id) {
            if (!isInt(id)) {
                return
            }
            this.$http.get('/api/examiner/' + id)
                .then(function (res) {
                    if (!res.data.isEmpty()) {
                        this.$set('result', true)
                    }
                    this.$set('results', res.data[0]);
                })
                .catch(function (err) {
                    console.log("Error: " + err);
                    throw err;
                });
        }
    }
});

var router = new VueRouter();
router.map({});
window.vue = vm;
Vue.config.debug = true;
   //
   // set("UserId", results.rows[0].UserId);
   //  set("EmailAddress", results.rows[0].EmailAddress);
   //  set("Digest", md5(results.rows[0].EmailAddress));
   //  set("Password", results.rows[0].Password);
   //  set("Created", results.rows[0].Created);
   //  set("OtherNames", results.rows[0].OtherName);
   //  set("LastName", results.rows[0].LastName);
   //  set("Title", results.rows[0].Title);
   //  set("DateOfBirth", results.rows[0].DateOfBirth);
   //  set("Role", results.rows[0].Role);
   //  set("Username", results.rows[0].Username);
   //  set("FirstName", results.rows[0].FirstName);
   //  if (results.rows[0].PostNominal != 'undefined') {
   //      set("PostNominal", results.rows[0].PostNominal);
   //  }