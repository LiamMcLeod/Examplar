   var searchPos, navPos;

    if (screen.width >= 1280) {
        invertNavbar();
        searchBarFix();
        //ToDo sort the searchbar out
    }


    function searchBarFix() {
        searchPos = $('.searchContainer').offset();
        $(window).scroll(function () {
            if ($(window).scrollTop() > searchPos.top) {
                $('#searchGroup').addClass("navbar-fixed-top");
                $('#searchGroup').removeClass("input-group-lg");
                $('#searchGroup').addClass("input-group-sm");
                $('#searchGroup').addClass("decreaseScale");
            } else {
                $('#searchGroup').removeClass("navbar-fixed-top");
                $('#searchGroup').removeClass("input-group-sm");
                $('#searchGroup').addClass("input-group-lg");
                $('#searchGroup').removeClass("decreaseScale");
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

function toggleMenu() {
    $('#mobileWrapper').toggleClass('hide');
    $('.icon').toggleClass('open')
}
function toggleHide(id) {
    $(id).toggleClass('hide');
}
function toggleOptions(id) {
    if ($('.contentOptions').hasClass('hide')) {
        toggleHide('.contentOptions');
    }
    toggleHide(id);
    if ($('#sort').hasClass('hide') && $('#filter').hasClass('hide')) {
        $('.contentOptions').toggleClass('hide')
    }
}