module PhxHamburgerHelper

  def phx_hamburger

    "<div class='phx-hamburger'>|||</div>".html_safe

  end

# ... or
#  def phx_hamburger
#     Q(<div class='col-xs-1 phx-hamburger-box'><button type='button' class='phx-hamburger'>|||</button></div>).html_safe
#  end

end