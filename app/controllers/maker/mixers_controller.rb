class Maker::MixersController < Cardtec::ActiveNodesController
  layout false

  def relationships_between
    @first_node = Maker::App.find(params[:mixer_id])
    @last_node  = Maker::App.find(params[:last_node_id])

    @all_relationship_types = Graph8.all_relationship_types
  end

  def related_nodes
    @node = Maker::App.find(params[:id])
  end

  def create
    props = Mida::Document.new(params[:cardtec_message]).items.first.flat_properties
    @subject_node  = neo4j_query.match(:n).where(n: { uuid: props[:subject_uuid] }).pluck(:n).first
    @object_node   = neo4j_query.match(:n).where(n: { uuid: props[:object_uuid] }).pluck(:n).first

    @relationship = Neo4j::Relationship.create(props[:predicate_title], @subject_node, @object_node)

    render :nothing => true
  end

end
