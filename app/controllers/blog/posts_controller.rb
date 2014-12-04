class Blog::PostsController < Cardtec::NodesController

  def index
    @nodes = Blog::Post.all
  end

  def new
    @node = Blog::Post.new.to_cardtec_node
  end

end
