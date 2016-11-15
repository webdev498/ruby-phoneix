module PhxSubnavHelper

  def phx_subnav_for main_menu_selection

    content_for :phx_subnav do
  	  render partial: 'common/' << PhxMenu.phx_main_menus[main_menu_selection]
    end

  end

end
