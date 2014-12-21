class Cardtec::ActiveNodesController < Cardtec::CypherNodesController
  include ModelKlassConversion
  layout :init_layout

  before_action :prepend_current_app_as_view_path
  before_action :init_dingos


  private

    # initializations

    def init_nodes
      @nodes = model_klass.all.order('n.updated_at DESC').limit(Rails.env.development? ? 40 : 300)
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


    # operations

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


    # misc

    def init_side_navigation_items
    #   @side_navigation_items =
    #     neo4j_query.match(n: model_klass_name_space).pluck('DISTINCT labels(n) AS labels').flatten.uniq.sort
      @side_navigation_items = model_klass.all.order('n.title').limit(25)
    end


    def neo_node_to_param(neo_node)
      neo_node.to_param
    end


    def init_layout
      request.xhr? || params[:layout] == 'false' ? false : 'application'
    end

    def prepend_current_app_as_view_path
      prepend_view_path(Rails.root.join('app/views', controller_path.split('/').first))
    end

    def init_dingos
      @dingos = Me.current.dingos
    end

end