module PhxTextareaForHelper

  def phx_textarea_for model, field, prompt, rows, tabindex = 0, css_class = ""

# code below TO BE compressed at a later date

  	textfield = capture do concat model.text_area(field, class: 'phx-form-control phx-textarea-limitwidth', rows: rows, tabindex: tabindex)  end
  	model_name = model.object_name

    tfld1 = "<div class='#{css_class} field form-group phx-input-control'>"
  	tfld2 = "<label class='phx-form-control-label' for='#{model_name}_#{field}'>#{prompt}</label>"
  	tfld4 = '</div>'
    tfld = tfld1 + tfld2 + textfield + tfld4

    tfld.html_safe

  end

end
