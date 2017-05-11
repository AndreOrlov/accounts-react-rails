@RecordForm = React.createClass
  getInitialState: ->
    title: ''
    date: ''
    amount: ''
    formErrors: {}

  valid: ->
    @state.title && @state.date && @state.amount

  handleChange: (e) ->
    name = e.target.name
    @setState "#{ name }": e.target.value

  handleSubmit: (e) ->
    e.preventDefault()
#    $.post '', { record: @state }, (data) =>
#      @props.handleNewRecord data
#      @setState @getInitialState()
#    , 'JSON'
    $.ajax
      method: 'POST'
      url: "/records"
      dataType: 'JSON'
      data: record: @state
      success: (data) =>
        @props.handleNewRecord data
        @setState @getInitialState()
      error: (response, status, err) =>
        @setState formErrors: response.responseJSON


  render: ->
    React.DOM.form
      className: 'form-inline'
      onSubmit: @handleSubmit
      React.DOM.div
        className: 'form-group'
        React.DOM.input
          type: 'text'
          className: 'form-control'
          placeholder: 'Date'
          name: 'date'
          value: @state.date
          onChange: @handleChange
      React.DOM.div
        className: 'form-group'
        React.DOM.input
          type: 'text'
          className: 'form-control'
          placeholder: 'Title'
          name: 'title'
          value: @state.title
          onChange: @handleChange
      React.DOM.div
        className: 'form-group' + if @state.formErrors['amount'] then ' has-error' else ''
        React.DOM.input
          type: 'number'
          className: 'form-control'
          placeholder: 'Amount'
          name: 'amount'
          value: @state.amount
          onChange: @handleChange
      React.DOM.button
        type: 'submit'
        className: 'btn btn-primary'
        disabled: !@valid()
        'Create record'
