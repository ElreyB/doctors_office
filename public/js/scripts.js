$(document).ready(function(){
  $("button.add_doctor").click(function(e){
    var doctorInput = $("#doctor")
    var userInput = doctorInput.val();

    if (userInput === ""){
      e.preventDefault();
      doctorInput.parent().addClass("has-error");
      return;
    }
  });

  $("button.add_patient").click(function(e){
    var patientInput = $("#patient")
    var userInput = patientInput.val()
    if (userInput === ""){
      e.preventDefault();
      patientInput.parent().addClass("has-error");
      return;
    }

    var birthdayInput = $("#birthday")
    var userInput = birthdayInput.val()
    if (userInput === ""){
      e.preventDefault();
      birthdayInput.parent().addClass("has-error");
      return;
    }
  });
});
