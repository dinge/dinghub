class Cardtec::CypherNodesController < ApplicationController
  include CurrentPath

  def index
    init_nodes
    init_main_navigation_items
    init_side_navigation_items
    render_index
  end

  def new
    init_new_node
    init_main_navigation_items
    init_side_navigation_items
    render_new
  end

  def create
    create_node
    render_create
  end

  def show
    init_node
    init_main_navigation_items
    init_side_navigation_items
    render_show
  end

  def update
    init_node
    update_node
    render_update
  end

  def destroy
    init_node
    destroy_node
    render_destroy
  end

  def filtered
    init_filtered_nodes
    init_main_navigation_items
    init_side_navigation_items
    render_filtered
  end




  private

    # initializations

    def init_nodes
      @nodes = neo4j_query.match(:n).return(:n).map(&:n)
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


    # operations

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


    # renderer

    def render_index
      respond_to do |format|
        format.js
        format.html
      end
    end

    def render_new  ; end
    def render_show ; end

    def render_create
      respond_to do |format|
        format.js
        format.html { redirect_to current_show_path(@node) }
      end
    end

    def render_update
      respond_to do |format|
        format.html { redirect_to current_show_path(@node) }
        format.js
      end
    end

    def render_destroy
      redirect_to current_index_path
    end

    def render_filtered
      render :index
    end


    # misc

    def init_main_navigation_items
      @main_navigation_items = MainNavigation.items
    end

    def init_side_navigation_items
      @side_navigation_items =
        neo4j_query.match(:n).pluck('DISTINCT labels(n) AS labels').flatten.uniq.sort
    end

    def neo4j_query
      Neo4j::Session.query
    end

    def neo_node_to_param(neo_node)
      neo_node.neo_id
    end

end