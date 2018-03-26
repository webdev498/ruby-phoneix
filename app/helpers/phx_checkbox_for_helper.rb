module PhxCheckboxForHelper

  def phx_checkbox_for model, field, prompt, tabindex = 0, css_class = ""

# lots of lines of code below TO BE compressed at a later date

  	checkbox = capture do concat model.check_box(field, class: 'phx-form-control', tabindex: tabindex)  end
  	model_name = model.object_name.gsub(/[\]\[]+/, '_').chomp '_'
    cb1 = "<div class='#{css_class} form-inline phx-adjust-checkbox'>"  \
      + '<div class="form-group phx-input-control">'  \
  		+ '<div class="phx-checkbox form-control-static">'

  	cb2 = "<label for='#{model_name}_#{field}'></label>" \
  		+ '</div>' \
  		+ '<label class="phx-checkbox-label" for='

  	cb3 = "'#{model_name}_#{field}''>#{prompt}</label>"

  	cb4 = '</div>'  \
  		+ '</div>'

    cb = cb1 + checkbox + cb2 + cb3 + cb4

    cb.html_safe

  end

end
