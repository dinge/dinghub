class Maker::MixersController < ApplicationController
  layout false

  def relationships_between
    @first_node = Graph8.find_by_uuid(params[:mixer_id])
    @last_node  = Graph8.find_by_uuid(params[:last_node_id])

    @all_relationship_types = Graph8.all_relationship_types
  end

  def related_nodes
    @rel_types_with_nodes_to = group_related_nodes(
      neo4j_query.match('(n)-[r]->(o)').where(n: {uuid: params[:id] }).pluck('TYPE(r), o')
    )

    @rel_types_with_nodes_from = group_related_nodes(
      neo4j_query.match('(n)<-[r]-(o)').where(n: {uuid: params[:id] }).pluck('TYPE(r), o')
    )
  end

  def create
    props = Mida::Document.new(params[:cardtec_message]).items.first.flat_properties
    @subject_node   = Graph8.find_by_uuid(props[:subject_uuid])
    @object_node    = Graph8.find_by_uuid(props[:object_uuid])
    @relationship   = Neo4j::Relationship.create(props[:predicate_title], @subject_node, @object_node)

    render :nothing => true
  end



  private

    def group_related_nodes(rels_with_nodes)
      rels_with_nodes.inject({}) do |hash, rn|
        hash[rn.first] ||= []
        hash[rn.first] << rn.last
        hash
      end
    end


end
