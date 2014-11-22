module CypherNodeExtension
  def method_missing(method, *args)
    if props.key?(method)
      props[method]
    else
      super
    end
  end
end

Neo4j::Server::CypherNode.send(:include, CypherNodeExtension)