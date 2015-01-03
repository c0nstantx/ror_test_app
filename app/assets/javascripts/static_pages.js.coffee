# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
`
$(document).on("keyup", "#micropost_content", function() {
    string = $(this).val();
    stringLength = string.length;
    if (stringLength > 140) {
        $(this).val(string.substring(0, 140));
        stringLength = 140;
    }
    $("#count").html(140-stringLength);
});
`