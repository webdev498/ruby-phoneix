$ ->
  $("#prescription_dispense_as_written_code").on("keypress", (evt) ->
    console.log("Pressed",evt.charCode)
    return false
    )
