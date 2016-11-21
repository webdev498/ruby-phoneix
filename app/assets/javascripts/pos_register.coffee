$ ->
  fetchRxOrItem = (valueToSearchFor,quantity) ->
    $.ajax("pos_details/get_rx_or_item?id=" + item + "&quantity="+ quantity,
      method: "get",
    ).done((data) ->
      debugger
      $("#new-compound-search").html(data)
      $("#new-pos-desc").focus()
    ).fail((data) ->
      alert("Item not found")
    )

  $("#new-pos-rx-upc-number").off().bind('keyup', (e)->
    debugger
    quantity = $("#new-pos-qty").val()
    if e?.keyCode == 13
      e.preventDefault()
      quantity = $("#new-pos-qty").val()
      valueToSearchFor = $("#new-pos-rx-upc-number").val()
      fetchRxOrItem(valueToSearchFor,quantity)

  )