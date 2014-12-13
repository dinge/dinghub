module ApplicationHelper

  def trio_panel(left = nil, center = nil, right = nil)
    content_tag(:div, class: :trio_panel) do
      content_tag(:div, left,   class: :left) <<
      content_tag(:div, center, class: :center) <<
      content_tag(:div, right,  class: :right)
    end
  end

  def duo_panel(left = nil, right = nil)
    content_tag(:div, class: :duo_panel) do
      content_tag(:div, left,   class: :left) <<
      content_tag(:div, right,  class: :right)
    end
  end

  def only_on_desktop_screen(&block)
    capture(&block) unless browser.mobile? || browser.tablet?
  end

end