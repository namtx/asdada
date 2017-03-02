$(document).on('turbolinks:load', function(){
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

  $('.multi-item-carousel').carousel({
    interval: 2000
  });

  $('.multi-item-carousel .item').each(function(){
    var next = $(this).next();
    if (!next.length) {
      next = $(this).siblings(':first');
    }
    next.children(':first-child').clone().appendTo($(this));

    if (next.next().length>0) {
      next.next().children(':first-child').clone().appendTo($(this));
    } else {
    	$(this).siblings(':first').children(':first-child').clone().appendTo($(this));
    }
  });

  $('.hot-trends-items').slick({
    infinite: true,
    slidesToShow: 3,
    slidesToScroll: 3,
    autoplay: true,
    autoplaySpeed: 2000
  });

  $('#price-slider').slider({});

  $('.product-rate').raty({
    path: '/assets',
    starOff: 'star-off.png',
    starOn: 'star-on.png',
    readOnly: true,
    score: function(){
      return $(this).attr('data-score');
    }
  });

  $('.user-rate-product').raty({
    path: '/assets',
    starOff: 'star-off.png',
    starOn: 'star-on.png',
    score: function(){
      return $(this).attr('data-score');
    },
    click: function(score, event){
      product_id = $('.user-rate-product').attr('product-id');
      $.ajax({
        method: 'post',
        url: product_id+'/ratings',
        data: {
          rating: {
            point: score
          }
        },
        success: function(){
          $('.user-rate-product').raty('score', score);
        }
      });
      return false;
    },
  });

  $('.recently-viewed-rating').raty({
    path: '/assets',
    starOff: 'star-off.png',
    starOn: 'star-on.png',
    score: function(){
      return $(this).attr('data-score');
    },
    readOnly: true
  });

  function loadFacebookComment(d, s, id) {
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) return;
    js = d.createElement(s); js.id = id;
    js.src = "//connect.facebook.net/en_US/sdk.js#xfbml=1&version=v2.8&appId=213223815761488";
    fjs.parentNode.insertBefore(js, fjs);
  };

  loadFacebookComment(document, 'script', 'facebook-jssdk');
});
