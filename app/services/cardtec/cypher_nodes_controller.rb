class Cardtec::CypherNodesController < ApplicationController
  include CurrentPath
  before_action :prepend_current_app_as_view_path
  before_action :init_main_navigation_items


  def index
    init_nodes
    init_side_navigation_items
  end

  def new
    init_new_node
    init_side_navigation_items
  end

  def create
    create_node
    respond_to do |format|
      format.html { redirect_to current_show_path(@node) }
      format.js
    end
  end

  def show
    init_node
    init_side_navigation_items
  end

  def update
    init_node
    update_node
    respond_to do |format|
      format.html { redirect_to current_show_path(@node) }
      format.js
    end
  end

  def destroy
    init_node
    destroy_node
    redirect_to current_index_path
  end

  def filtered
    init_filtered_nodes
    init_side_navigation_items
    render :index
  end




  private

    def init_nodes
      @nodes = neo4j_query.match(:n).return(:n).map(&:n)
    # rescue NameError
    #   @nodes = neo4j_query.match(:n).where('NOT (HAS (n._classname))').return(:n).map(&:n)
    end

    def init_node
      # @node = neo4j_query.match(:n).where(n: { neo_id: params[:id] }).return(:n).first.n
      @node = Neo4j::Node.load(params[:id]).neo4j_obj
    end

    def init_new_node
      @node = Cardtec::Node.new
    end

    def init_filtered_nodes
      @nodes = neo4j_query.match(n: params[:filter]).return(:n).map(&:n)
    end


    def create_node
      @node = if yaml = params[:cardtec_node][:yaml]
        Cardtec::Node.create_from_yaml(yaml)
      elsif html = params[:cardtec_node][:html]
        Cardtec::Node.create_from_html(html)
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
      @node.del
    end

    def init_main_navigation_items
      @main_navigation_items = MainNavigation.items
    end


    def init_side_navigation_items
      @side_navigation_items =
        neo4j_query.match(:n).pluck('DISTINCT labels(n) AS labels').flatten.uniq.sort
    end


    def prepend_current_app_as_view_path
      prepend_view_path(Rails.root.join('app/views', controller_path.split('/').first))
    end

    def neo4j_query
      Neo4j::Session.query
    end

    def neo_node_to_param(neo_node)
      neo_node.neo_id
    end

end