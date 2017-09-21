$(document).on("change", ".product-quantity", function(e){
  var quantity = $(this).val();
  var productId = $(this).closest('tr').data('productId');

  $.ajax({
    url: '/carts/' + productId +'/add_to_cart',
    method: 'POST',
    data: {
      product_quantity: quantity
    }
  }).success(function (data) {
    console.log(data);
  }).error(function (data) {
    console.log(data);
  })
})

$(document).on("click", "#alertSection .close-alert", function(e){
  $('#alertSection').addClass('hidden');
  $('#alertSection').removeClass('alert-success alert-danger');
  $('#alertSection span').text('');
});