module PhxToggleSliderHelper

  def phx_toggle_slider field_class, field_name, on_label, off_label

    fieldClassName = field_class.object_name
    %Q(
    <div class='onoffswitch'>
      <input type='checkbox' name='#{fieldClassName}[#{field_name}]' class='onoffswitch-checkbox' id='#{fieldClassName}_#{field_name}' checked>
      <label class='phx-sliderswitch-label' for='#{fieldClassName}_#{field_name}'>
        <span class='onoffswitch-inner' data-switch-on='#{on_label}' data-switch-off='#{off_label}'></span>
        <span class='phx-sliderswitch-switch'></span>
      </label>
    </div>
    ).html_safe

  end

end