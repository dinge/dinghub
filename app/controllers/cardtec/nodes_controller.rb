class Cardtec::NodesController < ApplicationController
  skip_before_action :verify_authenticity_token # TODO: remove

  before_action :prepend_current_app_as_view_path
  # before_action :init_node, only: [:show, :update, :destroy]
  before_action :init_navigation_container_elements, only: [:index, :new, :show, :by_container]



  def index
    @nodes = neo4j_query.match(:n).return(:n).map(&:n)
  end

  def new
    @node = Cardtec::Node.new
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

  def show
    init_node
  end

  def update
    init_node
    if yaml = params[:cardtec_node][:yaml]
      @node.ctn.update_from_yaml(yaml)
    elsif html = params[:cardtec_node][:html]
      @node.ctn.update_from_html(html)
    end
    redirect_to current_show_path(@node.neo_id)
  end

  def destroy
    init_node
    @node.del
    redirect_to current_index_path
  end

  def by_container
    @nodes = neo4j_query.match(n: params[:container]).return(:n).map(&:n)
    render :index
  end




  private

    def init_node
      @node = Neo4j::Node.load(params[:id])
    end

    def init_navigation_container_elements
      @navigation_container_elements =
        neo4j_query.match(:n).pluck('DISTINCT labels(n) AS labels').flatten.uniq.sort
    end


    def neo4j_query
      Neo4j::Session.query
    end

    def prepend_current_app_as_view_path
      prepend_view_path(Rails.root.join('app/views', controller_path.split('/').first))
    end

end