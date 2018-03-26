module PhxButtonForHelper

    def phx_red_submit_button_for( model, captionSuffix="", alternateCaptions=nil, name="", cssClass="", disabled=false )

        buttonClass = "phx-btn-model-control-red " << cssClass
        phx_button_for model, captionSuffix, alternateCaptions, name, buttonClass, disabled

    end

    def phx_white_submit_button_for( model, captionSuffix="", alternateCaptions=[], name="", cssClass="", disabled=false )

        buttonClass = "phx-btn-model-control-white " << cssClass
        phx_button_for model, captionSuffix, alternateCaptions, name, buttonClass, disabled

    end

    def phx_yellow_submit_button_for( model, captionSuffix="", alternateCaptions=[], name="", cssClass="", disabled=false )

        buttonClass = "phx-btn-model-control-cream " << cssClass
        phx_button_for model, captionSuffix, alternateCaptions, name, buttonClass, disabled

    end

    def phx_blue_submit_button_for( model, captionSuffix="", alternateCaptions=[], name="", cssClass="", disabled=false, remote = false, id = nil, overrideCaption = nil, tabindex = nil )

        buttonClass = "phx-btn-model-control-blue " << cssClass
        phx_button_for model, captionSuffix, alternateCaptions, name, buttonClass, disabled, remote, id, overrideCaption, tabindex

    end

    def phx_red_submit_button_for( model, captionSuffix="", alternateCaptions=nil, name="", cssClass="", disabled=false, remote = false, id = nil )

      buttonClass = "phx-btn-model-control-red " << cssClass
      phx_button_for model, captionSuffix, alternateCaptions, name, buttonClass, disabled, remote, id

    end


private

    # alternateCaptions[0] - create caption
    # alternateCaptions[1] - update caption
    def phx_button_for( model, captionSuffix, alternateCaptions, name, cssClass, disabled = false, remote = false, id = nil, overrideCaption = nil, tabindex = nil )

      buttonClass = "btn btn-sm btn-default " << cssClass
      if overrideCaption
        fullCaption = overrideCaption
      elsif !alternateCaptions.present?
          fullCaption = (model.object.persisted? ? "Update " : "Create ") << captionSuffix
      else
          fullCaption = model.object.persisted? ? alternateCaptions[1] : alternateCaptions[0]
      end
      # let rails generate the html
      if tabindex
        button = capture do concat model.submit( fullCaption, name: name, class: buttonClass, disabled: disabled, remote: remote, id: id, tabindex: tabindex )  end
      else
        button = capture do concat model.submit( fullCaption, name: name, class: buttonClass, disabled: disabled, remote: remote, id: id )  end

      end

      button.html_safe

    end

end
