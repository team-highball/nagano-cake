$(document).on 'turbolinks:load', ->
  $('#client_postal_code').jpostal
    postcode: ['#client_postal_code']
    address:  '#client_address': '%3%4%5%6'
