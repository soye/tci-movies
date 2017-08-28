$(document).on "turbolinks:load", ->
  # add 'checked' class to selected star rating
  $('label[for*="review_rating"]').click ->
    $('.rating span').removeClass 'checked'
    $(this).parent().addClass 'checked'