class Modix::NodesController < ApplicationController
  before_filter :init_node, only: [:show]
  before_filter :init_navigation_container_elements

  def index
    @nodes = neo4j_query.match(:n).return(:n).map(&:n)
  end

  def new
    @node = Cardtec::Node.new(OpenStruct.new(props: {}))
  end

  def create
    @node = Cardtec::Node.create_from_yaml(params[:cardtec_node][:yaml])
    redirect_to current_show_path(@cardtec.neo_id)
  end

  def show; end

  def update
    @node = Cardtec.query.match(:n).where(n: { neo_id: params[:id] }).return(:n).first.n.to_cardtec_node
    @node.update_from_yaml(params[:cardtec_node][:yaml])
    redirect_to current_show_path(@node.neo_id)
  end

  def by_container
    @nodes = neo4j_query.match(n: params[:label]).return(:n).map(&:n)
    render :index
  end

  def destroy
    Neo4j::Node.load(params[:id]).del
    redirect_to current_index_path
  end



  private

    def init_node
      # @cardtec_node = Cardtec.query.match(:n).where(n: { neo_id: params[:id] }).return(:n).first.n.to_cardtec_node
      @node = Neo4j::Node.load(params[:id]).to_cardtec_node
    end

    def init_navigation_container_elements
      @navigation_container_elements = neo4j_query.match(:n).pluck('DISTINCT labels(n) AS labels').flatten.uniq.sort
    end



end
