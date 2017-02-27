$(function(){
  $('.number-spinner .btn').on('click', function(){
    var oldVal = $(this).closest('.number-spinner').find('input').val().trim();
    var newVal = 0;
    if($(this).attr('data-dir')=='up'){
      newVal = parseInt(oldVal)+1;
    }else{
      if(oldVal > 1){
        newVal = parseInt(oldVal) - 1;
      }else {
        newVal = 1;
      }
    }
    $(this).closest('.number-spinner').find('input').val(newVal);
  });

  $('input.only-number').on('keyup', function(event){
    if(isNaN($(this).val())){
      $(this).val(1)
    }
  });

  function readURL(input) {
    if (input.files && input.files[0]) {
      var reader = new FileReader();

      reader.onload = function (e) {
        $('#img_prev').attr('src', e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
    }
  }

  $('#image-upload').change(function(){
    $('#img_prev').removeClass('hidden');
    readURL(this);
  });
});
