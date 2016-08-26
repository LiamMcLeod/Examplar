var all = new Vue({
    components: {
        alert: VueStrap.alert
    },

    el: '#wrapper',
    data: {},
    route: {},
    ready: function () {
    },
    methods: {}
});
window.vue = all;
Vue.config.debug = true;