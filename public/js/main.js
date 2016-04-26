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
