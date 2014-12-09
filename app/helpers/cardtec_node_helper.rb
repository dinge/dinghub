module CardtecNodeHelper
  def cardtec_node_actions(left = nil, center = nil, right = nil)
    render 'node_actions', left: left, center: center, right: right
  end
end