class Modix::ConceptsController < Cardtec::NodesController

  def index
    # @nodes = neo4j_query.match(:n).return(:n).map(&:n)
    @nodes = Modix::Concept.all
  end

  def new
    @node = Modix::Concept.new.to_cardtec_node
  end


  def create
    @node =
      if yaml = params[:cardtec_node][:yaml]
        Cardtec::Node.create_from_yaml(yaml)
      elsif html = params[:cardtec_node][:html]
        Cardtec::Node.create_from_html(html)
      end

    redirect_to current_show_path(@node.neo_id)
  end



  private

    def init_navigation_container_elements
      @navigation_container_elements =
        neo4j_query.match('(n:Modix)').pluck('DISTINCT labels(n) AS labels').flatten.uniq.sort
    end


end
