#= require bootstrap/modal
#= require bootstrap/transition
#= require_tree .

$ ->
  $('input#favorite-beer-other').on 'click', ->
    otherText = $('#favorite-beer-other-text')
    $(otherText).prop('disabled', !$(otherText).prop('disabled'))
    $(otherText).focus()

  $('#reservation-modal, #newsletter-modal').on 'shown.bs.modal', ->
    $(this).find('form input:first').focus()

  $('button[data-form-submit]').on 'click', (e) ->
    e.preventDefault()
    $(this).parents('.modal').find('form').submit()

  $('#js-reservation-form').on 'submit', (e) ->
    e.preventDefault()

    form = new Form($(this))

    if form.valid()
      $.ajax
        url: $(this).prop('action')
        data: $(this).serialize()
        type: 'POST'
        dataType: 'jsonp'
      .always =>
        $(this).addClass('hidden')
        $('#js-reservation-submit').addClass('hidden')
        $('#js-reservation-thanks').removeClass('hidden')

  $('#js-newsletter-form').on 'submit', (e) ->
    e.preventDefault()

    form = new Form($(this))

    if form.valid()
      $.ajax
        url: $(this).prop('action')
        data: $(this).serialize()
        type: 'POST'
        dataType: 'jsonp'
      .done (data) =>
        if data.result == 'error'
          $('#js-newsletter-error').removeClass('hidden')
        else
          $(this).addClass('hidden')
          $('#js-newsletter-submit').addClass('hidden')
          $('#js-newsletter-error').addClass('hidden')
          $('#js-newsletter-thanks').removeClass('hidden')
