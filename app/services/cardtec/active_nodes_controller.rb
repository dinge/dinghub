class Cardtec::ActiveNodesController < Cardtec::CypherNodesController



  private

    def init_nodes
      @nodes = model_klass.all
    end

    def init_node
      @node = model_klass.find(params[:id])
    end

    def init_new_node
      @node = model_klass.new
    end

    def init_filtered_nodes
      @nodes = neo4j_query.match(n: params[:filter]).where("n:`#{model_klass_name_space}`").return(:n).map(&:n)
    end


    def create_node
      @node = if yaml = params[:cardtec_node][:yaml]
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


    def init_side_navigation_items
      @side_navigation_items =
        neo4j_query.match(n: model_klass_name_space).pluck('DISTINCT labels(n) AS labels').flatten.uniq.sort
    end



    def model_klass_name
      controller_path.singularize.camelize
    end

    def model_klass
      model_klass_name.constantize
    end

    def model_klass_name_space
      model_klass_name.split('::').first
    end

end