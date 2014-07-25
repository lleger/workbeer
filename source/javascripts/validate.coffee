$ ->
  class Form
    EMAIL_REGEX = /// ^
    (
      ([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*) # no special chars
      |(\".+\") # user - match anything else
    )
    @ # must include @ sign
    (
      (\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\]) # match ip address
      |(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}) # match domain
    )
    $ ///

    constructor: (@selector) ->
      @feedbackMarkup = """
      <span class="glyphicon glyphicon-remove form-control-feedback"></span>
      """
      @emailMessageMarkup = """
      <span class="validation-message help-block">
        Must be a valid email address.
      </span>
      """

    valid: ->
      @resetValidation()
      @_runValidations [
        @validateRequired(),
        @validateEmail()
      ]

    resetValidation: ->
      container = @selector.find('.form-group')
      $(container).removeClass('has-error')
      $(container).removeClass('has-feedback')
      $(container).children('.form-control-feedback').remove()
      $(container).children('.validation-message').remove()

    validateRequired: ->
      @_runValidations [
        @_validateRequiredInput(),
        @_validateRequiredSelect(),
        @_validateRequiredGroup()
      ]

    validateEmail: ->
      valid = true
      @selector.find('input[data-validate-email]').map (index, element) =>
        if !EMAIL_REGEX.test($(element).val())
          valid = false
          $(element).parents('.form-group').addClass('has-error')
          $(element).parents('.form-group').addClass('has-feedback')
          if !$(element).parents('.form-group')
                        .find('form-control-feedback').length
            $(element).parents('.form-group').append @feedbackMarkup
          if !$(element).parents('.form-group')
                        .find('.validation-message').length
            $(element).parents('.form-group').append @emailMessageMarkup
      valid

    _runValidations: (validators) ->
      validators.every((e) -> e == true )

    _validateRequiredInput: ->
      valid = true
      @selector.find('input[data-required]').map (index, element) =>
        if !$(element).val()
          valid = false
          formGroup = $(element).parents('.form-group')
          $(formGroup).addClass('has-error')
          $(formGroup).addClass('has-feedback')
          if !$(formGroup).find('form-control-feedback').length
            $(formGroup).append @feedbackMarkup
      valid

    _validateRequiredSelect: ->
      valid = true
      @selector.find('select[data-required]').map ->
        if !$(this).val()
          valid = false
          formGroup = $(this).parents('.form-group')
          $(formGroup).addClass('has-error')
          $(formGroup).addClass('has-feedback')
      valid

    _validateRequiredGroup: ->
      valid = true
      @selector.find('input[data-required-group]').map ->
        group = $(this).data('required-group')
        if !$("input[name=\"#{group}\"]:checked").val()
          valid = false
          $(this).parents('.form-group').addClass('has-error')
          $(this).parents('.form-group').addClass('has-feedback')
      valid

  window.Form = Form
