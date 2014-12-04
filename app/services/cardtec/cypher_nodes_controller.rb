class Cardtec::CypherNodesController < ApplicationController
  include ControllerExtensions::PathExtension

  # skip_before_action :verify_authenticity_token # TODO: remove
  before_action :prepend_current_app_as_view_path


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
      format.html { redirect_to current_show_path(@node.neo_id) }
      format.js   { render js: "window.location.pathname = '#{current_show_path(@node.neo_id)}'"}
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
      format.html { redirect_to current_show_path(@node.neo_id) }
      format.js { render js: "window.location.pathname = '#{current_show_path(@node.neo_id)}'"}
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
    end

    def init_node
      @node = Neo4j::Node.load(params[:id])
    end

    def init_new_mode
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

end