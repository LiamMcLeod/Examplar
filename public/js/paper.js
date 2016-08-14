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
 *TODO Sanitise input
 *TODO Figure hover image
 *TODO CLEAN TODOS
 * //Random Question Function
 * // More questions comes up with itself
 * TODO TAGGING / Categories
 * TODO profile
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

var up;
up = new Vue({

    // Element
    el: '#wrapper',

    data: {
        //sort
        sortBy: '',
        sortType: 1,
        sortOptions: sortOptions,
        sortOrder: sortOrder, //1 or -1
        //filter
        filterOptions: filterOptions,
        filterTermOptions: [],
        filterBy: '',
        filterTerm: '',
        filterFlag: false,
        //misc
        noOfResults: 0,
        noOfPages: 0,
        error: '',
        //Paper
        papers: [],
        paperFlag: false,
        //Questions
        questions: [],

    },

    route: {},

    ready: function () {

    },

    methods: {
        fetchPapers: function (id) {
            if (!isInt(id)) {
                return
            }
            this.$set('papers', []);
            this.$http.get('/api/user/' + id + '/papers/')
                .then(function (res) {
                    if (isset(res.data[0])) {
                        this.$set('paperFlag', true);
                        var noOfResults = res.data.length;
                        var noOfPages = noOfResults / 5;
                        this.$set('noOfResults', noOfResults);
                        this.$set('noOfPages', noOfPages);

                        for (var i = 0; i < res.data.length; i++) {
                            this.$set('papers[' + i + ']', res.data[i]);
                        }
                        this.$set('noOfResults', this.results.length);
                    }
                })
                .catch(function (err) {
                    console.log("Error: " + err);
                    throw err;
                });

        },
        fetchPaper: function (id) {
            this.$http.get('/api/paper/' + id)
                .then(function (res) {
                    if (isset(res.data[0].QuestionId)) {
                        this.$set('questionFlag', true)
                    }
                    var questions = [];
                    var noOfResults = res.data.length;
                    var noOfPages = noOfResults / 15;
                    this.$set('noOfResults', noOfResults);
                    this.$set('noOfPages', noOfPages);
                    for (var i = 0; i < res.data.length; i++) {
                        this.$set('questions[' + i + ']', res.data[i]);
                    }
                    this.$set('noOfResults', this.results.length);
                    this.$set('searchFlag', 1);
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
window.vue = up;
Vue.config.debug = true;