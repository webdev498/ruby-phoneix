module PhxEnumRadioForHelper

  def phx_enum_radio_for model, field, prompt, enumeration = {}, enumLabels = [], tabindex = 0, css_class = ""

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

    # TODO: get rid of the style below
    radio_group = "<div class='' style='margin-left:8px; padding-bottom:6px;'>#{prompt}:</div>"
    enumeration.each_with_index do |enum, index|

      enumLabel = enumLabels.empty? ? enum.first : enumLabels[index]
      tfld1 = "<div class='#{css_class} radio phx-input-control'>"
      # TODO: get rid of the style below
      tfld2 = "<label class='phx-form-control-label' style='margin-left:5px;'>"
      # let rails generate the html
      radioButton = capture do concat radio_button( model_name, field, enum.first )  end
      tfld3 = "#{enumLabel}</label></div>"

      radio_group += em1div + em2div + em3div + tfld1 + tfld2 + radioButton + tfld3
    end

    radio_group.html_safe
  end

end
