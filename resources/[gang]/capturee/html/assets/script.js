$(document).ready(function(){
  window.addEventListener("message", function(event){
    if(event.data.update == true){
      clearInterval(x);
      $(".capturedby").text(event.data.Handeler);
      setProgress(event.data.Time);
    }else if(event.data.start == true){
      $(".capturename").text(titleCase(event.data.CapName));
      $(".captureimg").attr('src','assets/imgs/' + event.data.CapName.toLowerCase() + '.jpg');
      $("body").fadeIn(400);
    }else if(event.data.stop == true){
      $("body").fadeOut(400);
    }
  });

  var x
  function setProgress(time){
    var distance = time+1;    
    x = setInterval(function() {
      distance += -1;
      var percent =  100 - (distance/6);
      $('.processtime').width(percent + '%');

      var mins = ("0" + Math.floor(distance/60)).slice(-2);
      var secs = ("0" + Math.floor(distance%60)).slice(-2);
      $(".time").html(mins + ":" + secs); 

      if (distance <= 0) {
        clearInterval(x);
      }
    }, 1000);

  }

  function titleCase(str) {
    var splitStr = str.toLowerCase().split('_');
    for (var i = 0; i < splitStr.length; i++) {
        splitStr[i] = splitStr[i].charAt(0).toUpperCase() + splitStr[i].substring(1);     
    }
    return splitStr.join(' '); 
  }
});