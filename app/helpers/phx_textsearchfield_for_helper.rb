module PhxTextsearchfieldForHelper

  def phx_textsearchfield_for model, field, prompt, tabindex = 0, css_class = "", readonly=nil

      phx_textfield_for model, field, prompt, tabindex, css_class, readonly, true

  end

end
