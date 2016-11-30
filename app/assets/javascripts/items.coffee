root = exports ? this

# This is a global method allowing us access to it throughout the app
# We use this to trigger an update of the data in the formula tab without
# have to leave the view and do a full refresh and loose the tab position
root.updateFormulaData = ->
  formula_id = $(".update-formula")[0].id.split("_")[2]
  $.get("/formulas/" + formula_id + ".json", (data) ->
    $("#item_formula_attributes_number_legend_ingredients").val(data.number_legend_ingredients)
    $("#item_formula_attributes_number_otc_ingredients").val(data.number_otc_ingredients)
  )

# This is a global method allowing us reattach event handlers to the
# ingredients pane. Since we support editing of alot of the settings
# inline we refresh the Table via ajax, so after the refresh we
# need to reattach the handlers to the table
# We use the .off() to avoid attaching a handler twice
root.attachIngredientSearchHandlers = ->

  # Show the formula copy search modal
  $("#copy-formula-to-ingedient").off().click((e) ->
    e.preventDefault()
    $("#item-target-to-copy-formula-modal").modal("show")
  )

  # Handle selecting an item from the formula search modal
  $("#item-to-copy-formula-to-modal").off().bind('keypress', (e)->
    if(e?.keyCode == 13)
      e.preventDefault()
      valueToSearchFor = $("#item-to-copy-formula-to-modal").val()
      start_id = "?start="+valueToSearchFor+"&page=1";
      $.get( '/item/nextItemFormulaToCopy' + start_id, (data) ->

      );
      console.log("Search for ingredient")
      return false
    else
      return true
  )

  # Method used when we add a new ingredient
  # once everything is saved we re grab a partial of
  # the formula ingredients table and repopulate the
  # HTML for the table - then reattach event handlers
  saveIngredient = ->
    basis_of_cost = $("#new-compound-basis")[0].selectedIndex
    quantity = $("#new-compound-quantity").val()
    item_id = $("#new-compound-item-id").val()
    parent_item_id = $("#formula-parent-item-id").val()
    $.post( "/formulas/addIngredient", {
      compound_id: parent_item_id,
      ingredient: {
        item_id: item_id,
        basis_of_cost: basis_of_cost,
        quantity: quantity
      }
    }).done( (data) ->
      $.get("/formulas/ingredients/" + parent_item_id, (data) ->
        $("#ingredient-list").html(data)
        resetIngredientForm()
        setIngredientRowHandlers()
        $("#new-compound-ingredient").focus()
        updateFormulaData()
      )
    )

  # Handle the selection of a new ingredient item
  $("#new-compound-ingredient").off().bind('keypress', (e)->
    if(e?.keyCode == 13)
      e.preventDefault()
      valueToSearchFor = $("#new-compound-ingredient").val()
      start_id = "?start="+valueToSearchFor+"&page=1";
      $.get( '/item/nextIngredients' + start_id, (data) ->

      );
      console.log("Search for ingredient")
      return false
    else
      return true
  )

  # Handle the event to search for an ingredient to replace an
  # existing ingredient
  $(".existing-ingredient-name").off().bind('keypress', (e)->
    if(e?.keyCode == 13)
      e.preventDefault()
      valueToSearchFor = e.currentTarget.value
      ingredientId = e.currentTarget.id.split("-name-")[1]
      start_id = "?start="+valueToSearchFor+"&page=1&ingredient_id="+ingredientId
      $.get( '/item/nextExistingIngredients' + start_id, (data) ->

      );
      console.log("Search for esixting ingredient")
      return false
    else
      return true

  )

  # Handling the key press on the new compound quantity
  # if the key is enter add it to the formula
  # otherwise go grab the new price to show the user
  $(".new-compound").off().bind('keyup', (e)->
    item_id = $("#new-compound-item-id").val()
    item_quantity = $("#new-compound-quantity").val()
    item_basis = $("#new-compound-basis").val()
    if item_id && item_quantity && item_basis != undefined && item_basis > -1
      query = "?item_id=" + item_id + "&quantity=" + item_quantity + "&basis=" + item_basis
      $.get( ('/ingredients/price' + query),(data) ->
        $("#new-compound-cost").val(data.price)
      )
  )

  # Handling the key press on the new compound quantity
  # if the key is enter add it to the formula
  # otherwise go grab the new price to show the user
  $(".new-compound").off().bind('keypress', (e)->
    if(e?.keyCode == 13)
      e.preventDefault()
      saveIngredient()
      return false
    else
      item_id = $("#new-compound-item-id").val()
      item_quantity = $("#new-compound-quantity").val()
      item_basis = $("#new-compound-basis-value-id").val()
      if item_id && item_quantity && item_basis != undefined && item_basis > -1
        query = "?item_id=" + item_id + "&quantity=" + item_quantity + "&basis=" + item_basis
        $.get( ('/ingredients/price' + query),(data) ->
          $("#new-compound-cost").val(data.price)
        )
      return true
  )

  $("#new-compound-basis").off().bind('change', (e)->
    item_id = $("#new-compound-item-id").val()
    item_quantity = $("#new-compound-quantity").val()
    item_basis = $("#new-compound-basis-value-id").val()
    if item_id && item_quantity && item_basis != undefined && item_basis > -1
      query = "?item_id=" + item_id + "&quantity=" + item_quantity + "&basis=" + item_basis
      $.get( ('/ingredients/price' + query),(data) ->
        $("#new-compound-cost").val(data.price)
      )
  )
  resetIngredientForm = ->
    $("#new-compound-basis")[0].selectedIndex = null
    $("#new-compound-quantity").val(null)
    $("#new-compound-item-id").val(null)
    $("#new-compound-ingredient").val(null)

  $("#item-add-compound-button").off().click (e) ->
    e.preventDefault()
    saveIngredient()

  # When we update a formula ingredients we will use ajax
  # to update the otc/legend counts
  updateFormulaData = ->
    formula_id = $(".update-formula")[0].id.split("_")[2]
    $.get("/formulas/" + formula_id + ".json", (data) ->
      $("#item_formula_attributes_number_legend_ingredients").val(data.number_legend_ingredients)
      $("#item_formula_attributes_number_otc_ingredients").val(data.number_otc_ingredients)
    )


  # Helper method to grab values for AJAX calls to update a formula
  getFormulaParams = ->
    params = {}
    compound_form = $("#item_formula_attributes_compound_form")[0].selectedIndex
    dispensing_unit = $("#item_formula_attributes_dispensing_unit")[0].selectedIndex
    #quantity_produced = $("#item_formula_attributes_quantity_produced").val() -- UNDEFINED IN DB
    level_of_effort_code = $("#item_formula_attributes_level_of_effort_code")[0].selectedIndex
    route_of_administration = $("#item_formula_attributes_route_of_administration").val()
    number_legend_ingredients = $("#item_formula_attributes_number_legend_ingredients").val()
    number_otc_ingredients = $("#item_formula_attributes_number_otc_ingredients").val()
    instructions = $("#item_formula_attributes_instructions").val()
    quantity_produced = $("#item_formula_attributes_quantity_produced").val()

    params["compound_form"] = compound_form
    params["dispensing_unit"] = dispensing_unit
    params["level_of_effort_code"] = level_of_effort_code
    params["route_of_administration"] = route_of_administration
    params["number_legend_ingredients"] = number_legend_ingredients
    params["number_otc_ingredients"] = number_otc_ingredients
    params["instructions"] = instructions
    params["quantity_produced"] = quantity_produced

    return params

  # The handler for the update formula button
  $(".update-formula").off().click( (e) ->
    e.preventDefault()
    params = {}
    params["formula"] = getFormulaParams()
    formula_id = $(".update-formula")[0].id.split("_")[2] # we add this ID in the button helper - since we have 3 forms on the page basically
    method = "put"
    path = "/formulas"
    if(formula_id == "unknown")
      method = "post"
      #params["id"] = $("#formula-parent-item-id").val()
    else
      path += ("/" + formula_id)
      params["id"] = $("#formula-parent-item-id").val()

    $.ajax(path,
      data: params,
      method: method,
      dataType: "json"
    ).done((data) ->
      console.log("Successfully to " + path + " " + method + " the formula " + params)
    ).fail((data) ->
      console.log("Failed to " + path + " " + method + " the formula " + params)
    )
    console.log("updating the formula",JSON.stringify(params))
    return false
  )


root.setIngredientRowHandlers = ->

  # This method calls the ingredient delete and then refreshes the
  # ingredients and formula information table using updateFormulaData()
  deleteIngredient = (e) ->
    e.preventDefault()
    ingredientId = e.target.id.split("-delete-")[1]
    $.ajax("/formulas/removeIngredient/" + ingredientId,
      method: "delete",
    ).done((data) ->
      updateFormulaData()
      console.log("Success Deleting ingredient")
    ).fail((data) ->
      console.log("Failed to " + path + " " + method + " the formula " + params)
    )
    false

  $(".ingredient-delete").off().click( (e) ->
    deleteIngredient(e)
    return false
  )

  # The delete existing ingredient handler
  $(".ingredient-delete").off().bind('keypress', (e)->
    if(e?.keyCode == 13)
      e.preventDefault()
      deleteIngredient(e)
      updateFormulaData()
      return false
    else
      return true

  )

  # This is the handler where we trigger a new ingredient
  # search for and EXISTING ingredient

  $(".existing-ingredient-name").off().bind('keypress', (e)->
    if(e?.keyCode == 13)
      e.preventDefault()
      valueToSearchFor = e.currentTarget.value
      ingredientId = e.currentTarget.id.split("-name-")[1]
      start_id = "?start="+valueToSearchFor+"&page=1&ingredient_id="+ingredientId
      $.get( '/item/nextExistingIngredients' + start_id, (data) ->

      );
      console.log("Search for esixting ingredient")
      return false
    else
      return true

  )

  # This is the handler where we accept changes to the
  # quantity field in an existing ingredient
  # We actually update the ingredient model when the enter
  # key is pressed
  $(".existing-ingredient-quantity").off().bind('keypress', (e)->
    if(e?.keyCode == 13)
      e.preventDefault()
      ingredientId = e.target.id.split("-quantity-")[1]
      quantity = e.target.value
      item_basis = $("#new-compound-basis-value-id").val()

      if ingredientId && quantity && item_basis != undefined && item_basis > -1
        query = "?ingredient_id=" + ingredientId + "&quantity=" + quantity + "&basis=" + item_basis
        $.get( ('/ingredients/price' + query),(data) ->
          $("#ingredient-base-cost-" + ingredientId).html(data.price)
          $.ajax({
            url: "/ingredients/" + ingredientId,
            data: {
              ingredient: {
                quantity: quantity,
                id: ingredientId
              }
            },
            method: "put",
            dataType: "json"
            success: (data) ->
          })
        )
      return false
    else
      return true
  )

  # This method sets up the behavior where the formula instructions
  # modal is launched when the user tabs to that field

  $("#item_formula_attributes_instructions").off().focusin ->
    $("#compound-instructions-modal").modal("show")

  # This method sets up the save handler for the formula instructions modal

  $("#formula-modal-savechanges").off().click ->
    newInstructions = $("#formula-modal-instructions").val()
    formula_id = $(".update-formula")[0].id.split("_")[2]
    console.log("Save",newInstructions)
    $.ajax({
      url: "/formulas/" + formula_id,
      method: "put",
      data: {
        formula: {
          instructions: newInstructions
        }
      },
      dataType: "json"
    }).done( (data) ->
      $("#item_formula_attributes_instructions").val(newInstructions)
      $("#compound-instructions-modal").modal("hide")
      $(".update-formula").focus()
    )

# This global method sets up the handlers for the
# formula copy modal
root.setupFormulaCopy = ->
  onIngredientsKeys0_9 = ->
    that = this
    $('#itemFormulaSearchModal_Keys1_9').on 'keypress', (evt) ->
      key = if evt.charCode then evt.charCode else if evt.keyCode then evt.keyCode else 0
      if key >= 48 and key <= 57
  # gather up all the data values and remember them in our model and respective hidden fields
        target = $('#itemSearchModal-row' + (key - 48).toString())
        # id is always a defined field and only shows in valid search rows
        if target.attr('data-phx-search-item-id') != undefined
          processItemFormualaToCopySearchSelection target.attr('data-phx-search-item-id')
        return false
      # <esc> key - close the search modal
      # signal escaped
      if key == 27
        $('#SearchModal-close-btn').trigger 'click'
        return false
      # <+> key - open page to create a new model instance
      if key == 43
        $('#SearchModal-close-btn').trigger 'click'
        return false
      # enter key -> do nothing
      if key == 13
        return false
      return
    return

  # This gets the compound info that we want to
  # copy the formula to, it shows the selected item
  # details
  processItemFormualaToCopySearchSelection = (selectedSearchItemId) ->
    $.get( ('/items/' + selectedSearchItemId + ".json" ), (data) ->
      console.log((data));
      $("#item-to-copy-formula-to-modal").val(data.item_name);
      $("#item-target-to-copy-formula-selected-id").val(data.id);
      $("#formula-modal-savechanges").focus();
      )
    return

  onModalButtons = ->
    $("#formula-copy-modal-savechanges").on 'keypress', (evt) ->
      key = if evt.charCode then evt.charCode else if evt.keyCode then evt.keyCode else 0

      if key == 27
        $('#formula-modal-dismiss').trigger 'click'
        return false
      # <+> key - open page to create a new model instance

      if key == 13
        copyToFormula evt
        return false

      return true

  # This is the handler that is triggered when
  # search results for the formula copy modal are returned
  $("#item-target-to-copy-formula-modal").bind('itemformalacopysearchcontentchanged', ->
    onIngredientsKeys0_9()
    onModalButtons()

    $("#itemFor mulaSearchModal_Keys1_9").focus();
    $(".clickable-itemSearchModal-row").off().click ->
      processItemFormualaToCopySearchSelection $(this)
  )

  # This method will take the selected formula and target compound and then
  # copy the formula contents to the new compound
  # At the end we navigate to the new compound
  copyToFormula = (e) ->
    e.preventDefault()
    formula_id = $(".update-formula")[0].id.split("_")[2]
    itemToCopyFormulaToId = $("#item-target-to-copy-formula-selected-id").val()
    $.ajax({
      url: "/item/copyFormula",
      data: {
        formula_id: formula_id,
        target_item_id: itemToCopyFormulaToId
      },
      method: "put"
    }).done( (data) ->
      window.location.pathname = "/items/" + itemToCopyFormulaToId
    )
  $("#formula-copy-modal-savechanges").click (e) ->
    copyToFormula e

  console.log("setupFormulaCopy setup complete")
$ ->
  attachIngredientSearchHandlers();
  setIngredientRowHandlers();
  setupFormulaCopy();

  # turbolinks event for page load
  document.addEventListener("page:load", ->
    attachIngredientSearchHandlers();
    setIngredientRowHandlers();
    setupFormulaCopy();
  )


