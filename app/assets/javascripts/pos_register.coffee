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
        updatePaymentTotals()
        reattachFormListeners()
      )
    )

  updateRegisterFields = (json,tablehtml) ->
    $("#pos_transaction_initials").val(json.initials)
    $("#pos_transaction_register_number").val(json.register_number)
    formattedDate = (new Date(json.created_at)).toLocaleDateString().replace(/\//g,"-")
    $("#pos_transaction_transaction_date").val(formattedDate)
    $("#pos_transaction_medical_amount").val(json.medical_amount)
    $("#pos_transaction_medical_tax").val(json.medical_tax)
    $("#pos_transaction_non_medical_amount").val(json.non_medical_amount)
    $("#pos_transaction_non_medical_tax").val(json.non_medical_tax)
    $("#pos_transaction_medical_total").val(json.medical_total)
    $("#pos_transaction_non_medical_total").val(json.non_medical_total)
    $("#pos_transaction_total_amount").val(json.total_amount)
    $("#pos_transaction_total_tax").val(json.total_tax)
    $("#pos_transaction_total_due").val( (json.total_amount + json.total_tax) )
    $("#pos_transaction_items_count").val( 20 )

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

  getPosParams = ->
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
    posParams

  reattachFormListeners = ->
    $("#new-pos-desc").off().bind('keyup', (e)->
      quantity = $("#new-pos-qty").val()
      description = $("#new-pos-desc").val()
      itemid =  $("#new-pos-rx-upc-number").val()
      transactionId = $("#transaction-id").val()
      pos_transaction_date = $("#pos_transaction_transaction_date").val()
      pos_transaction_initials = $("#pos_transaction_initials").val()
      pos_transaction_register_number = $("#pos_transaction_register_number").val()
      posParams = getPosParams()

      if ( e?.keyCode == 13 )
        e.preventDefault()
        saveNewItem(itemid,quantity,description,transactionId,posParams)
    )

    $("#new-pos-rx-upc-number").off().bind('keyup', (e)->
      quantity = $("#new-pos-qty").val()
      if $("#new-pos-rx-upc-number").val() != "" && e?.keyCode == 13
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

    updatePrimaryPayments = (amount,method,callback) ->
      transactionId = $("#transaction-id").val()
      posParams = getPosParams()
      posParams.primary_payment_amount = amount
      posParams.primary_payment_method = amount
      $.ajax({
        url: "/pos_transactions/create_or_update",
        method: "post",
        data: {
          transactionId: transactionId,
          pos_header: posParams,
        },
        dataType: "json"
      }).done( ->
        callback()
      )

    updateSecondaryPayments = (amount,method,callback) ->
      transactionId = $("#transaction-id").val()
      posParams = getPosParams()
      posParams.secondary_payment_amount = amount
      posParams.secondary_payment_method = amount
      $.ajax({
        url: "/pos_transactions/create_or_update",
        method: "post",
        data: {
          transactionId: transactionId,
          pos_header: posParams,
        },
        dataType: "json"
      }).done( ->
        callback()
      )

    $("#pos_transaction_primary_payment_amount").off().bind('keyup', (e)->
      transactionId = $("#transaction-id").val()
      amount = $("#pos_transaction_primary_payment_amount").val()
      method = $("#pos_transaction_primary_payment_method").val()
      if transactionId != "" && e?.keyCode == 13  && amount != ""
        e.preventDefault()
        updatePrimaryPayments(amount,method, ->
          updatePaymentTotals()
          $("#pos_transaction_secondary_payment_method").focus()
        )

    )

    $("#pos_transaction_secondary_payment_amount").off().bind('keyup', (e)->
      transactionId = $("#transaction-id").val()
      amount = $("#pos_transaction_secondary_payment_amount").val()
      method = $("#pos_transaction_secondary_payment_method").val()
      if transactionId != "" && e?.keyCode == 13   && amount != ""
        e.preventDefault()
        updateSecondaryPayments(amount,method, ->
          updatePaymentTotals()
          $("#pos_transaction_print_receipt").focus()

        )

    )



    deleteDetail = (e) ->
      e.preventDefault()
      transactionId = $("#transaction-id").val()
      detailId = e.target.id.split("-delete-")[1]
      $.ajax({
        url: "/pos_transactions/delete_detail",
        method: "delete",
        data: {
          detailId: detailId,
          transactionId: transactionId
        }
      }).done( (tablehtml) ->
        $("#pos-items-list").html(tablehtml)
        transactionId = $("#transaction-id").val()
        $.ajax(
          url: "/pos_transactions/view/" + transactionId + ".json",
          dataType: "json"
        ).done( (data) ->
          updateRegisterFields(data,tablehtml)
          updatePaymentTotals()
          reattachFormListeners()
        )
      )

    $(".detail-delete").off().click( (e) ->
      deleteDetail(e)
      return false
    )

    $(".detail-delete").bind('keypress', (e)->
      if(e?.keyCode == 13)
        e.preventDefault()
        deleteDetail(e)
        return false
      else
        return true

    )

  reattachFormListeners()
  document.addEventListener("page:load", ->
    reattachFormListeners()
  )



