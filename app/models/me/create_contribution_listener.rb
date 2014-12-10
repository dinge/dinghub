class Me::CreateContributionListener

  def node_saved(node, me_current)
    if me_current && node.respond_to?(:contributions)  # !node.is_a?(Me::Contribution)
      Rails.logger.info "#### actor '#{me_current.title}' contributed to node #{node} #{node.props[:uuid]}"
      me_current.contributions << Me::Contribution.new(thing: node)
    end
  end

end