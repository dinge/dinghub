module ApplicationHelper

  def cardtec_node_actions(left = nil, center = nil, right = nil)
    render 'node_actions', left: left, center: center, right: right
  end

  def only_on_desktop_screen(&block)
    capture(&block) unless browser.mobile? || browser.tablet?
  end

end
