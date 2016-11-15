module PhxDatefieldForHelper

  def phx_datefield_for model, field, prompt, tabindex = 0, css_class = ""

    if !model.object.nil?
        value = model.object.send(field).to_phxDateString
    else
        value = ""
    end

    model_name = model.object_name
    textfield = capture do concat model.text_field( field, value: value, class: 'phx-form-control datepicker') end
    tfld1 = "<div class='#{css_class} field form-group phx-input-control'>"
  	tfld2 = "<label class='phx-form-control-label' for='#{model_name}_#{field}'>#{prompt}</label>"
  	tfld4 = '</div>'
    tfld = tfld1 + tfld2 + textfield + tfld4

    tfld.html_safe

  end

end
