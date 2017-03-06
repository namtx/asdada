$(document).on('turbolinks:load', function(){
  $('input.only-number').on('keyup', function(event){
    if(isNaN($(this).val())){
      $(this).val(1)
    }
  });

  $(document).on('click', '')
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
    $('#current-profile-image').addClass('hidden');
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

  $('.slider-vertical').remove();
  $('#price-slider').slider({});

  $('.product-rate').empty();
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

  $('.admin-rate-product').raty({
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

  function selectedTab(){
    url = window.location.href
    console.log(url.split('?tab=')[1]);
    if (url.split('?tab=')[1] === 'suggested_product_tab'){
      $('a[href="#suggested_product_tab"]').tab('show');
    }
  }

  selectedTab();
});



$(document).on('click', '.number-spinner .btn', {}, function(e){
  currentVal = $(e.currentTarget).parent().parent().find('input').val();
  if($(e.currentTarget).attr('data-dir')=='up'){
    newVal = 1
  }else{
    if (currentVal === '1'){
      return false;
    }
    newVal = -1
  }
  product_id = $(e.currentTarget).attr('product');
  $.ajax({
    method: 'post',
    url: 'carts/',
    data: {
      product_id: product_id,
      quantity: newVal
    }
  });
  return false;
});

$(document).on('click', 'a.btn-remove-product', {}, function(e){
  product_id = $(e.currentTarget).attr('product');
  $.ajax({
    method: 'delete',
    url: '/carts',
    data: {
      product_id: product_id
    },
  });
  return false;
});

$(document).on('click', 'a.btn-add-to-cart', {}, function(e){
  product_id = $(e.currentTarget).attr('product');
  $.ajax({
    method: 'post',
    url: '/carts',
    data: {
      product_id: product_id,
      quantity: 1
    },
    beforeSend: function(){
      $('#fakeLoader').fakeLoader({
        timeToHide: 30,
        spinner: 'spinner7',
        bgColor: 'rgba(0, 0, 0, 0.5)'
      });
    }
  });
  return false;
});
