class Blog::PostsController < Cardtec::NodesController

  def index
    @nodes = Blog::Post.all
  end

  def new
    @node = Blog::Post.new
  end

  def create
    @node =
      if yaml = params[:cardtec_node][:yaml]
        Blog::Post.ctn.create_from_yaml(yaml)
      elsif html = params[:cardtec_node][:html]
        Blog::Post.ctn.create_from_yaml(html)
      end

    redirect_to current_show_path(@node.neo_id)
  end

end
