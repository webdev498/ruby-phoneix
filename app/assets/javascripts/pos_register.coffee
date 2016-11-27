$ ->
  fetchRxOrItem = (valueToSearchFor,quantity) ->
    $.ajax("/pos_details/get_rx_or_item?id=" + valueToSearchFor + "&quantity="+ quantity,
      method: "get",
    ).done((data) ->
      $("#new-compound-search").html(data)
      $("#new-pos-desc").focus()
      reattachFormListeners()
    ).fail((data) ->
      alert("Item not found")
    )



  saveNewItem = (itemId,quantity,description,transactionId,posParams) ->
    $.ajax({
      url: "/pos_transactions/add_new_detail",
      method: "post",
      data: {
        quantity: quantity,
        description: description,
        itemId: itemId,
        transactionId: transactionId,
        pos_header: posParams,
      }
    }).done( (tablehtml) ->
      $("#pos-items-list").html(tablehtml)
      transactionId = $("#transaction-id").val()
      $.ajax(
        url: "/pos_transactions/view/" + transactionId + ".json",
        dataType: "json"
      ).done( (data) ->
        updateRegisterFields(data,tablehtml)
      )
    )

  updateRegisterFields = (json,tablehtml) ->
    $("#pos_transaction_initials").val(json.initials)
    $("#pos_transaction_register_number").val(json.register_number)
    $("#pos_transaction_transaction_date").val(json.transaction_date)
    $("#pos_transaction_medical_amount").val(json.medical_amount)
    $("#pos_transaction_medical_tax").val(json.medical_tax)
    $("#pos_transaction_non_medical_amount").val(json.non_medical_amount)
    $("#pos_transaction_non_medical_tax").val(json.non_medical_tax)
    $("#pos_transaction_medical_total").val(json.medical_total)
    $("#pos_transaction_non_medical_total").val(json.non_medical_total)
    $("#pos_transaction_total_amount").val(json.total_amount)
    $("#pos_transaction_total_tax").val(json.total_tax)


    # Clear the fields to en
    $("#new-pos-qty").val("")
    $("#new-pos-type").val("")
    $("#new-pos-rx-upc-number").val("")
    $("#new-pos-med").val("")
    $("#new-pos-desc").val("")
    $("#new-pos-each").val("")
    $("#new-pos-total").val("")

    $("#new-pos-qty").focus()
    reattachFormListeners()


  reattachFormListeners = ->
    $("#new-pos-desc").off().bind('keyup', (e)->
      quantity = $("#new-pos-qty").val()
      description = $("#new-pos-desc").val()
      itemid =  $("#new-pos-rx-upc-number").val()
      transactionId = $("#transaction-id").val()
      pos_transaction_date = $("#pos_transaction_transaction_date").val()
      pos_transaction_initials = $("#pos_transaction_initials").val()
      pos_transaction_register_number = $("#pos_transaction_register_number").val()
      pos_transaction_primary_payment_method = $("#pos_transaction_primary_payment_method").val()
      pos_transaction_primary_payment_amount = $("#pos_transaction_primary_payment_amount").val()
      pos_transaction_secondary_payment_method = $("#pos_transaction_secondary_payment_method").val()
      pos_transaction_secondary_payment_amount = $("#pos_transaction_secondary_payment_amount").val()

      posParams = {
        initials: pos_transaction_initials,
        register_number: pos_transaction_register_number,
        transaction_date: pos_transaction_date,
        primary_payment_method: pos_transaction_primary_payment_method,
        primary_payment_amount: pos_transaction_primary_payment_amount,
        secondary_payment_method: pos_transaction_secondary_payment_method,
        secondary_payment_amount: pos_transaction_secondary_payment_amount
      }

      if e?.keyCode == 13
        e.preventDefault()
        saveNewItem(itemid,quantity,description,transactionId,posParams)
    )

    $("#new-pos-rx-upc-number").off().bind('keyup', (e)->
      quantity = $("#new-pos-qty").val()
      if e?.keyCode == 13
        e.preventDefault()
        quantity = $("#new-pos-qty").val()
        valueToSearchFor = $("#new-pos-rx-upc-number").val()
        fetchRxOrItem(valueToSearchFor,quantity)
    )
  reattachFormListeners()
  document.addEventListener("page:load", ->
    reattachFormListeners()
  )



