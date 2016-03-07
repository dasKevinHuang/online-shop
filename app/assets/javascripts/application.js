// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
$(document).ready(function(){
  
  $('.quantity_increase').on('click', function(){
    $('.alert').remove();
    $(this).siblings('input').val(parseInt($(this).siblings('input').val()) + 1)
  })

  $('.quantity_decrease').on('click', function(){
    $('.alert').remove();
    var current_quantity = parseInt($(this).siblings('input').val())
    if (current_quantity !== 0 ) { $(this).siblings('input').val(current_quantity - 1);}
  })
    


  $('#shopping_cart_table')
     .bind("ajax:success", function(evt, data, status, xhr){
      
      $('#shopping_cart_table').remove;
      $('.alert').remove();
      $('#shopping_cart_table').html(data);
      $('#cart_total').html($('#data-total').attr("data-total"));
      
    })

  // $('#add_to_cart_form')
  //   .bind("ajax:beforeSend", function(evt, xhr, settings){
  //     var $submitButton = $(this).find('input[name="commit"]');
  //     console.log("Test");

  //     // Update the text of the submit button to let the user know stuff is happening.
  //     // But first, store the original text of the submit button, so it can be restored when the request is finished.
  //   })
  //    .bind("ajax:success", function(evt, data, status, xhr){
  //     var $form = $(this);
  //     console.log(xhr.responseText);
  //     $form.find('textarea,input[type="text"],input[type="file"]').val("");
  //     $('#shopping_cart').append(xhr.responseText);
  //   })


});