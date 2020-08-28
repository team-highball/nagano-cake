$(document).on 'turbolinks:load', ->
  $('#client_postal_code , #shipping_address_postal_code , #order_new_add_postal_code').jpostal
    postcode: ['#client_postal_code , #shipping_address_postal_code , #order_new_add_postal_code']
    address:  '#client_address , #shipping_address_address , #order_new_add_address': '%3%4%5%6'
