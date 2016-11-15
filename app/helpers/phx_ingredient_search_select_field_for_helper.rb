module PhxIngredientSearchSelectFieldForHelper

  def phx_ingredient_search_select_field_for model_field, field, enumArray = {}
    enumSelection = {}
    enumArray.each do |value| enumSelection[value.humanize] = value end
    # enumSelection = humanize ? enumArray.inject({}) { |hash,(k,v)| hash[k.humanize] = v; hash} : enumHash
    selectfield = select_tag(field, options_for_select(enumSelection, model_field))
    tfld = selectfield
    tfld.html_safe

  end

end
