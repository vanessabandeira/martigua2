jQuery.fn.selectText = function(){
    var doc = document;
    var element = this[0];
    var range, selection;
    if (doc.body.createTextRange) {
        range = document.body.createTextRange();
        range.moveToElementText(element);
        range.select();
    } else if (window.getSelection) {
        selection = window.getSelection();
        range = document.createRange();
        range.selectNodeContents(element);
        selection.removeAllRanges();
        selection.addRange(range);
    }
};

$(document).on('turbolinks:load', function(){
  $("#mail-compo").click(function() {
    $('#mail-compo').selectText();
  });
});