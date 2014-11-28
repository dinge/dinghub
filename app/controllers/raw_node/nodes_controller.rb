class RawNode::NodesController < ApplicationController
  before_filter :init_node, only: [:show, :update, :destroy]
  before_filter :init_navigation_container_elements, only: [:index, :new, :show, :by_container]

  def index
    @nodes = neo4j_query.match(:n).return(:n).map(&:n)
  end

  def new
    @node = Cardtec::Node.new(OpenStruct.new(props: {}))
  end

  def create
    @node = Cardtec::Node.create_from_yaml(params[:cardtec_node][:yaml])
    redirect_to current_show_path(@node.neo_id)
  end

  def show; end

  def update
    @node.update_from_yaml(params[:cardtec_node][:yaml])
    redirect_to current_show_path(@node.neo_id)
  end

  def destroy
   @node.del
   redirect_to current_index_path
  end

  def by_container
    @nodes = neo4j_query.match(n: params[:container]).return(:n).map(&:n)
    render :index
  end




  private

    def init_node
      # @cardtec_node = Cardtec.query.match(:n).where(n: { neo_id: params[:id] }).return(:n).first.n.to_cardtec_node
      node = Neo4j::Node.load(params[:id])
      @node = (node.is_a?(Neo4j::Server::CypherNode) ? node : node.neo4j_obj).to_cardtec_node
    end

    def init_navigation_container_elements
      @navigation_container_elements = neo4j_query.match(:n).pluck('DISTINCT labels(n) AS labels').flatten.uniq.sort
    end


end

