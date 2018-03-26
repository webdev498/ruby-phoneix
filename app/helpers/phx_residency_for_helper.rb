module PhxResidencyForHelper

  def phx_residency_for faclity, field, prompt, tabindex = 0, css_class = ""

    # the residency object must know the facility, buildingwing, room and bed
    # if any of the items are flagged non-existent, then they shouldn't display below

    facility = phx_textfield_for faclity, field, "Facility", tabindex, ""
    building = phx_textfield_for faclity, field, "Building", tabindex, ""
    wing = phx_textfield_for faclity, field, "Wing", tabindex, ""
    room = phx_textfield_for faclity, field, "Room", tabindex, ""
    bed  = phx_textfield_for faclity, field, "Bed", tabindex, ""
    tfld = wing + room + bed

    tfld.html_safe

  end

end
