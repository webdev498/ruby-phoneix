$ ->
  fetchRxOrItem = (valueToSearchFor,quantity) ->
    $.ajax("/pos_details/get_rx_or_item?id=" + valueToSearchFor + "&quantity="+ quantity,
      method: "get",
    ).done((data) ->
      debugger
      $("#new-compound-search").html(data)
      $("#new-pos-desc").focus()
    ).fail((data) ->
      alert("Item not found")
    )

  $("#new-pos-rx-upc-number").off().bind('keyup', (e)->
    quantity = $("#new-pos-qty").val()
    if e?.keyCode == 13
      e.preventDefault()
      quantity = $("#new-pos-qty").val()
      valueToSearchFor = $("#new-pos-rx-upc-number").val()
      fetchRxOrItem(valueToSearchFor,quantity)
  )

  saveNewItem = (itemId,quantity,description,transactionId,posParams) ->
    $.ajax("/post_transaction/add_new"
      method: "post",
      data: {
        quantity: quantity,
        description: description,
        itemId: itemId,
        transactionId: transactionId,
        posParams: posParams
      }
    ).done( (data) ->
      $("#pos-items-list").html(data)
    ).fail((data) ->
      alert("Cannot add the item")
    )


  $("#new-pos-desc").off().bind('keyup', (e)->
    quantity = $("#new-pos-qty").val()
    description = $("#new-pos-desc").val()
    itemid =  $("#new-pos-rx-upc-number").val()
    transactionId = $("#transaction-id").val()
    pos_transaction_initials = $("#pos_transaction_initials").val()
    pos_transaction_register_number = $("#pos_transaction_register_number").val()
    pos_transaction_primary_payment_method = $("#pos_transaction_primary_payment_method").val()
    pos_transaction_primary_payment_amount = $("#pos_transaction_primary_payment_amount").val()
    pos_transaction_secondary_payment_method = $("#pos_transaction_secondary_payment_method").val()
    pos_transaction_secondary_payment_amount = $("#pos_transaction_secondary_payment_amount").val()

    posParams = {
      pos_transaction_initials: pos_transaction_initials,
      pos_transaction_register_number: pos_transaction_register_number,
      pos_transaction_primary_payment_method: pos_transaction_primary_payment_method,
      pos_transaction_primary_payment_amount: pos_transaction_primary_payment_amount,
      pos_transaction_secondary_payment_method: pos_transaction_secondary_payment_method,
      pos_transaction_secondary_payment_amount: pos_transaction_secondary_payment_amount,

    }

    if e?.keyCode == 13
      e.preventDefault()
      saveNewItem(itemid,quantity,description,transactionId,posParams)
  )