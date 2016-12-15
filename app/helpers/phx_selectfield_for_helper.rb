module PhxSelectfieldForHelper

  def phx_selectfield_for model, field, prompt, enumHash = {}, includeBlank = true, tabindex = nil, css_class = "", humanize = false, id = nil, return_just_input_box = false, select_size_class=""

    enumSelection = humanize ? enumHash.inject({}){|hash,(k,v)| hash[k.humanize] = v; hash} : enumHash
  	selectfield = capture do
      if tabindex
        concat model.select(field, options_for_select(enumSelection, model.object[field]),  includeBlank ? {include_blank: 'undefined'} : {}, {class: "phx-form-control #{select_size_class}", id: id,tabindex: tabindex})
      else
        concat model.select(field, options_for_select(enumSelection, model.object[field]),  includeBlank ? {include_blank: 'undefined'} : {}, {class: "phx-form-control #{select_size_class}", id: id})
      end
    end

  	model_name = model.object_name

    tfld1 = "<div class='#{css_class} field form-group phx-input-control'>"
    tfld2 = "<label class='phx-form-control-label' for='#{model_name}_#{field}'>#{prompt}</label>"
    tfld4 = '</div>'

    tfld = ""
    if return_just_input_box == true
      tfld = selectfield
    else
      tfld = tfld1 + tfld2 + selectfield + tfld4
    end

    tfld.html_safe

  end



end
