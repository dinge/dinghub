class Noodle::NodesController < ApplicationController
  layout 'noodle'
  before_filter :init_cardtec_node, only: [:show]
  before_filter :init_labels


  def index
    @nodes = query.match(:n).return(:n).map(&:n)
  end

  def new
    @node = Cardtec::Node.new(OpenStruct.new(props: {}))
  end

  def create
    @cardtec_node = Cardtec::Node.create_from_yaml(params[:cardtec_node][:yaml])
    redirect_to noodle_node_path(@cardtec_node.neo_id)
  end

  def show; end

  def update
    @cardtec_node = Cardtec.query.match(:n).where(n: { neo_id: params[:id] }).return(:n).first.n.to_cardtec_node
    @cardtec_node.update_from_yaml(params[:cardtec_node][:yaml])
    redirect_to noodle_node_path(@cardtec_node.neo_id)
  end

  def by_label
    @nodes = query.match(n: params[:label]).return(:n).map(&:n)
    render :index
  end

  def destroy
   Neo4j::Node.load(params[:id]).del
   redirect_to noodle_nodes_path
  end



  private

    def init_cardtec_node
      # @cardtec_node = Cardtec.query.match(:n).where(n: { neo_id: params[:id] }).return(:n).first.n.to_cardtec_node
      @node = Neo4j::Node.load(params[:id]).to_cardtec_node
    end

    def init_labels
      @labels = query.match(:n).pluck('DISTINCT labels(n) AS labels').flatten.uniq.sort
    end


end
