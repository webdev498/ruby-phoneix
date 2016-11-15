$ ->
  cs = FEENX.Search.NewSearch('account',
    context: ''
    triggerField: 'customer_full_name'
    fieldPrefix: ''
    modalId: 'accountSearchModal'
    hiddenDivId: 'hidden_fields'
    refresh: true
    refreshTo: '/accounts/')
  # additional attributes would be defined
  cs.addAttribute 'last_name', false, '', null
  cs.addAttribute 'display_name', false, '', null
  # create the corresponding hidden fields in the form
  cs.addHiddenFields()
  # create the corresponding data attribues in the modal rows
  cs.dataFormattedAttributes()

  $(".transaction_start_date").val($("#account_last_statement_date").val())

  $(".transaction_start_date").datepicker({
    format: 'mm-dd-yyyy',
    defaultViewDate: $("#account_last_statement_date").val(),
    autoclose: true,
    title: "Select transaction start date"
  }).on('changeDate' , ->
    $(".transaction_start_date").focus
    fetch_table_data(1)
  )

  # Setup the form with the default value
#  $(".transaction-start-date-picker").datepicker({
#    format: 'mm-dd-yyyy',
#    defaultViewDate: $("#account_last_statement_date").val(),
#    autoclose: true,
#    title: "Select transaction start date"
#  }).on('changeDate' , (e) ->
#    selectedDate = ((e.date.getMonth() + 1) + "-" + (e.date.getDate() + 1)+"-"+e.date.getFullYear())
#    $(".actual-date").html(selectedDate)
#    $("#account_last_statement_date").val(selectedDate)
#    $(".transaction-start-date-picker").datepicker().hide()
#    fetch_table_data(1)
#  )
#
#  $(".transaction-start-date-picker").datepicker().hide()
#
#  $(".transaction_start_date").click ->
#    $(".transaction-start-date-picker").datepicker().show()
#
#  $(".actual-date").html("Last Statement Date")

  fetch_table_data = (pageNumber)->
    account_number = $("#account_account_number").val()
    transactions_since = $(".transaction_start_date").val()
    currentPage = $("#account_postings_page_number").val()
    transaction_type = $(".account-posting-filter-option option:selected").val()
    $.get("/accounts/nextAccountPostings?account_number=" + account_number +
        "&transactions_since=" + transactions_since +
        "&transaction_type=" + transaction_type +
        "&page=" + pageNumber, ->
    ).done((data)->

    ).fail((error) ->
      console.log("Transaction fetch failed")
    )

  assignNextPreviousClickHandlers = ->
    $('#previous-account-postings-page').click (e)->
      e.preventDefault()
      currentPage = $("#account_postings_page_number").val()
      fetch_table_data((parseInt(currentPage) - 1))

    $('#next-account-postings-page').click (e)->
      e.preventDefault()
      currentPage = $("#account_postings_page_number").val()
      fetch_table_data((parseInt(currentPage) + 1))

  assignNextPreviousClickHandlers()

  $("#account_postings").bind("table-updated", ->
    assignNextPreviousClickHandlers()
  )

  $("#account_account_number").keypress (e)->
    accountNumber = $("#account_account_number").val()
    key = e.keyCode;
    if (key == 13)
      if accountNumber != undefined && accountNumber > 0
        window.location.replace("/accounts/" + accountNumber)

  $(".account-posting-filter-option").change ->
    transaction_type = $(".account-posting-filter-option option:selected").val()
    fetch_table_data(1) # Start back on page one
