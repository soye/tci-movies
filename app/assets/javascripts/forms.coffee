$(document).on "turbolinks:load", ->
  # add 'checked' class to selected star rating
  $('label[for*="review_rating"]').click ->
    $('.rating span').removeClass 'checked'
    $(this).parent().addClass 'checked'

# prevent enter from submitting forms for search and discover
$(document).on 'submit', 'form[class*="movies-"]', (e) ->
  if e.delegateTarget.activeElement.localName != 'button'
    e.preventDefault()
  return