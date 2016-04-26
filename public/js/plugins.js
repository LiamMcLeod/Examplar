$(document).ready(function () {

    var searchPos, navPos;

    if (screen.width >= 960) {
        invertNavbar();
        //searchBarFix();
        //ToDo sort the searchbar out
    }


    function searchBarFix() {
        searchPos = $('.contentHeader').offset();
        $(window).scroll(function () {
            if ($(window).scrollTop() > searchPos.top) {
                $('.searchContainer').addClass("decreaseScale");
                $('.searchContainer').addClass("navbar-fixed-top");
            } else {
                $('.searchContainer').removeClass("navbar-fixed-top");
                $('.searchContainer').removeClass("decreaseScale");
            }
        })
    }

    function invertNavbar() {
        navPos = $('#navTrigger').offset();
        $(window).scroll(function () {
            if ($(window).scrollTop() > navPos.top) {
                $('nav').removeClass("navbar-trans");
                $('.dropdown-menu').addClass("dark");
            } else {
                $('nav').addClass("navbar-trans");
                $('.dropdown-menu').removeClass("dark");
            }
        });
        // iPad
        $('body').on({
            'touchmove': function (e) {
                if ($(window).scrollTop() > navPos.top) {
                    $('nav').removeClass("navbar-trans");
                    $('.dropdown-menu').addClass("dark");
                } else {
                    $('nav').addClass("navbar-trans");
                    $('.dropdown-menu').removeClass("dark");
                }
            }
        });
    }

});