module ApplicationHelper

  def cardtec_node_actions(left = nil, center = nil, right = nil)
    render 'node_actions', left: left, center: center, right: right
  end

  def only_on_desktop_screen(&block)
    capture(&block) unless browser.mobile? || browser.tablet?
  end

end



# first_action do


# end.second_action do


# end.third_action do


# end





    # = panel do |p|
    #   = (f.button :submit, 'save', class: 'success radius right')
    #   - p.split


# - first_action do
#   #search

# - second_action do
#   #paginator

# - third_action do
#   #actions



# .columns.small-4
#   = left if left.present?
# .columns.small-4
#   = center if center.present?
# .columns.small-4
#   = right if right.present?