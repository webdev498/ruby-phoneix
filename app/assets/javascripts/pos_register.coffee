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
    $("#pos_transaction_total_due").val( (json.total_amount + json.total_tax) )

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
        transaction_date: pos_transaction_date
      }

      if(pos_transaction_primary_payment_amount != "")
        posParams["primary_payment_method"] = pos_transaction_primary_payment_method
        posParams["primary_payment_amount"] = pos_transaction_primary_payment_amount


      if(pos_transaction_secondary_payment_amount != "")
        posParams["secondary_payment_method"] = pos_transaction_secondary_payment_method
        posParams["secondary_payment_amount"] = pos_transaction_secondary_payment_amount

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

    updatePaymentTotals = ->
      primary_amount = parseFloat($("#pos_transaction_primary_payment_amount").val())
      secondary_amount = parseFloat($("#pos_transaction_secondary_payment_amount").val())
      if !secondary_amount
        secondary_amount = 0.0
      if !primary_amount
        primary_amount = 0.0
      $("#pos_transaction_primary_payment_amount").val(primary_amount.toFixed(2))
      $("#pos_transaction_secondary_payment_amount").val(secondary_amount.toFixed(2))

      paid_total = primary_amount + secondary_amount
      change_due = (( parseFloat($("#pos_transaction_total_amount").val()) - paid_total) * -1.0).toFixed(2)
      $(".total_paid").html("$" + paid_total.toFixed(2))
      if(change_due > 0.0)
        $(".change_due").html("$" + change_due)
      else
        $(".change_due").html("$0.00")

    updatePrimaryPayments = (amount,method) ->
      console.log("Undefined")
      updatePaymentTotals()

    updateSecondaryPayments = (amount,method) ->
      console.log("Undefined")
      updatePaymentTotals()

    $("#pos_transaction_primary_payment_amount").off().bind('keyup', (e)->
      amount = $("#pos_transaction_primary_payment_amount").val()
      method = $("#pos_transaction_primary_payment_method").val()
      if e?.keyCode == 13
        e.preventDefault()
        quantity = $("#new-pos-qty").val()
        updatePrimaryPayments(amount,method)
    )

    $("#pos_transaction_secondary_payment_amount").off().bind('keyup', (e)->
      amount = $("#pos_transaction_secondary_payment_amount").val()
      method = $("#pos_transaction_secondary_payment_method").val()
      if e?.keyCode == 13
        e.preventDefault()
        updateSecondaryPayments(amount,method)

    )

  reattachFormListeners()
  document.addEventListener("page:load", ->
    reattachFormListeners()
  )



