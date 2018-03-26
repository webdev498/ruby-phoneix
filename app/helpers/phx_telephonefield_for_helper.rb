module PhxTelephonefieldForHelper

  def phx_telephonefield_for model, field, prompt, tabindex = 0, css_class = "", readonly=nil, searchSource=false

  	model_name = model.object_name

    # TODO: refactor code below
    if !model.object.nil? and model.object.errors[field].present?
        css_class = " has-error "
        error_msg = model.object.errors[field].first
        em1div = "<div>"
        em2div = "<div class='pull-right phx-form-control-error'>#{error_msg}</div>"
        em3div = "</div>"
    else
        error_msg = ""
        em1div = ""
        em2div = ""
        em3div = ""
    end

    tfld1 = "<div class='#{css_class} field form-group phx-input-control'>"
  	tfld2 = "<label class='phx-form-control-label' for='#{model_name}_#{field}'>#{prompt}</label>"

    # let rails generate the html
    # TODO: clean up how we get the field value
    textfield = capture do concat model.telephone_field(field, value: number_to_phone(model.object[field]), class: 'phx-form-control'+(searchSource ? '-search' : ''), readonly: (readonly == :readonly))  end
  	tfld4 = '</div>'
    tfld = tfld1 + em1div + tfld2 + em2div + em3div + textfield + tfld4

    tfld.html_safe

  end

end
