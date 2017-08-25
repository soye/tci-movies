$ ->
  $('label[for*="review_rating"]').click ->
    $('.rating span').removeClass 'checked'
    $(this).parent().addClass 'checked'

  $('input:radio').change ->
    userRating = @value
    return