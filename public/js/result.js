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
function isset(x) {
    return ((typeof x) != 'undefined');
}
/*
 *TODO Figure hover image
 * //Random Question Function
 * // More questions comes up with itself
 * TODO TAGGING / Categories
 */
var data = {};
var results = [];
var user = [];
var examId, topicId;
var filterOptions = [
    {text: '', value: ''},
    {text: 'Unit', value: 'ExamPaperUnit'},
    {text: 'Subject', value: 'SubjectTitle'},
    {text: 'Level', value: 'LevelTitle'},
    {text: 'Exam Board', value: 'ExamBoardName'}
];
var sortOptions = [
    {text: 'Number', value: 'QuestionNumber'},
    {text: 'Alphabet', value: 'QuestionText'},
    {text: 'Year', value: 'ExamPaperYear'},
    {text: 'Unit', value: 'ExamPaperUnit'}
];
var sortOrder = [
    {text: 'Ascending', value: 1},
    {text: 'Descending', value: -1}
];

var qr;
qr = new Vue({
    components: {
        alert: VueStrap.alert
    },

    el: '#wrapper',

    data: {
        //Result
        hasImage: false,
        codeAnswer: false,
        result: false,
        results: [],
        more: [],
        related: [],
        // Error
        error: ''
    },

    route: {},

    ready: function () {

    },

    methods: {
        /************************
         *        Results Page    *
         ************************/
        fetchResult: function (id) {
            // TODO IF ID NOT INT
            if (!isInt(id)) {
                return
            }
            this.$set('results', []);               //Purge results
            this.$set('related', []);
            this.$set('more', []);

            this.$http.get('/api/result/' + id)
                .then(function (res) {
                    if (!res.data.isEmpty()) {
                        this.$set('result', true)
                    }
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
window.vue = qr;
Vue.config.debug = true;