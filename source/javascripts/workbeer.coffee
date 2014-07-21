$ ->
  $('input#pay-4-other').on 'click', ->
    $('#pay-4').prop('disabled', false)
    $('#pay-4').focus()

  $('#js-pay-form-group input[type="radio"]').on 'click', ->
    if $(this).prop('id') != 'pay-4-other'
      $('#pay-4').prop('disabled', true)

  $('input#favorite-beer-other').on 'click', ->
    otherText = $('#favorite-beer-other-text')
    $(otherText).prop('disabled', !$(otherText).prop('disabled'))
    $(otherText).focus()

  $('#reservation-modal').on 'shown.bs.modal', ->
    $('input#name').focus()

  $('#js-reservation-form input').on 'keydown', (e) ->
    if e.keyCode == 13
      $('#js-reservation-form').submit()

  $('#js-reservation-submit').on 'click', (e) ->
    e.preventDefault()
    $('#js-reservation-form').submit()

  $('#js-reservation-form').on 'submit', (e) ->
    e.preventDefault()

    resetValidation()
    validateRequired('input')
    validateRequired('select', false)
    validateGroupRequired()
    validateEmail()

    if !$('#js-reservation-form .form-group').hasClass('has-error')
      $.ajax
        url: $('#js-reservation-form').prop('action')
        data: $(this).serialize()
        type: 'POST'
        dataType: 'jsonp'
      .always ->
        $('#js-reservation-form').addClass('hidden')
        $('#js-reservation-submit').addClass('hidden')
        $('#js-reservation-thanks').removeClass('hidden')

  resetValidation = ->
    container = $('#js-reservation-form .form-group')
    $(container).removeClass('has-error')
    $(container).removeClass('has-feedback')
    $(container).children('.form-control-feedback').remove()
    $(container).children('.validation-message').remove()

  validateRequired = (selector, showFeedback = true) ->
    $("#js-reservation-form #{selector}[data-required]").map ->
      if !$(this).val()
        formGroup = $(this).parents('.form-group')
        $(formGroup).addClass('has-error')
        $(formGroup).addClass('has-feedback')
        if showFeedback && !$(formGroup).find('form-control-feedback').length
          $(formGroup).append('
            <span class="glyphicon glyphicon-remove form-control-feedback">
            </span>')

  validateGroupRequired = ->
    $('#js-reservation-form input[data-required-group]').map ->
      group = $(this).data('required-group')
      if !$("input[name=\"#{group}\"]:checked").val()
        $(this).parents('.form-group').addClass('has-error')
        $(this).parents('.form-group').addClass('has-feedback')

  validateEmail = ->
    $('#js-reservation-form input[data-validate-email]').map ->
      regex = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/

      if !regex.test($(this).val())
        $(this).parents('.form-group').addClass('has-error')
        $(this).parents('.form-group').addClass('has-feedback')
        if !$(this).parents('.form-group').find('form-control-feedback').length
          $(this).parents('.form-group').append('
            <span class="glyphicon glyphicon-remove form-control-feedback">
            </span>')
        if !$(this).parents('.form-group').find('.validation-message').length
          $(this).parents('.form-group').append('
            <span class="validation-message help-block">
              Must be a valid email address.
            </span>
          ')
