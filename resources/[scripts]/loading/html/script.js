$(document).ready(function($) {
    $('.input-text').keyup(function(event) {
        var textBox = event.target;
        var start = textBox.selectionStart;
        var end = textBox.selectionEnd;
        textBox.value = textBox.value.charAt(0).toUpperCase() + textBox.value.slice(1).toLowerCase();
    });
});

    window.addEventListener('message', function(event) {
        if (event.data.type == "enableui") {
            document.body.style.display = event.data.enable ? "block" : "none";
        }else if (event.data.action == "notification") {
          popupkon('Warning' ,event.data.message);
        }
    });

$("#name, #family").on("keydown", function(event){
  // Allow controls such as backspace, tab etc.
  var arr = [8,9,16,17,20,35,36,37,38,39,40,45,46];

  // Allow letters
  for(var i = 65; i <= 90; i++){
    arr.push(i);
  }

  // Prevent default if not in array
  if(jQuery.inArray(event.which, arr) === -1){
    event.preventDefault();
  }
});
$(document).ready(function() {
  $('#dateofbirth').datepicker({ dateFormat: 'yyyy-mm-dd' });
  $('.register').on('click', function(e){
    if(($('#name').val().length < 3 ) || ($('#family').val().length < 3 ) || ($('#name').val().length < 3 )) {
      popupkon('Warning', 'hade aghal bayad 3 character vared konid!');
      return false;
    } else {
      e.preventDefault(); // Prevent form from submitting
      $.post('http://loading/register', JSON.stringify({
        name: $("#name").val(),
        family: $("#family").val(),
        dateofbirth: $("#dateofbirth").val()
      }));
    }
  });
});
function popupkon(title,msg) {
  $('#modalTitle').text(title);
  $('#modalText').text(msg);
  $('#clicktomod').click();
}
