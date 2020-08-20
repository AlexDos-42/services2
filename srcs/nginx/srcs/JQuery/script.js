// script.js


$('#smiley').hide();


$('#Hide').click(function() {
    $('.bodier').slideToggle(500, 0, function() {
    });
    $('#smiley').slideToggle(500, 0, function() {
    });
});
