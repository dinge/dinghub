class Cardtec::ActiveNodesController < Cardtec::CypherNodesController

  def index
    @nodes = model_klass.all
    init_side_navigation_items
  end

  def new
    @node = model_klass.new
    init_side_navigation_items
  end


  def by_container
    @nodes = neo4j_query.match(n: params[:container]).return(:n).map(&:n)
    init_side_navigation_items
    render :index
  end



  private

    def init_node
      @node = model_klass.find_by_neo_id(params[:id])
    end

    def create_node
      if yaml = params[:cardtec_node][:yaml]
        model_klass.ctn.create_from_yaml(yaml)
      elsif html = params[:cardtec_node][:html]
        model_klass.ctn.create_from_html(html)
      end
    end

    def update_node
      if yaml = params[:cardtec_node][:yaml]
        @node.ctn.update_from_yaml(yaml)
      elsif html = params[:cardtec_node][:html]
        @node.ctn.update_from_html(html)
      end
    end

    def destroy_node
      @node.destroy
    end


    def model_klass_name
      controller_path.singularize.camelize
    end

    def model_klass
      model_klass_name.constantize
    end

    def init_side_navigation_items
      @side_navigation_items =
        neo4j_query.match('(n:Blog)').pluck('DISTINCT labels(n) AS labels').flatten.uniq.sort
    end

end