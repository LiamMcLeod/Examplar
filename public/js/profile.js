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

var fp;
fp = new Vue({
    components: {
        alert: VueStrap.alert
    },

    el: '#wrapper',

    data: {
        // User
        exists: false,
        user: [],
        // Error
        error: ''
    },

    route: {},

    ready: function () {

    },

    methods: {
        /************************
         *        Fetch Profile    *
         ************************/
        fetchProfile: function (user) {
            if (!isset(user)) {
                return;
            }
            this.$http.get('/api/user/' + user)
                .then(function (res) {
                    if (isset(res.data)) {
                        this.$set('exists', true);
                        this.$set('user', res.data);
                    }
                })
                .catch(function (err) {
                    console.log("Error: " + err);
                    throw err;
                });
        }
    }
});
window.vue = fp;
Vue.config.debug = true;