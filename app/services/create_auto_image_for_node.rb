class CreateAutoImageForNode

  def node_saved(node, me_current)
    node_klass = node.try(:neo_ruby_klass) || node.class
    if node_klass == Maker::Concept && node.respond_to?(:image) && !node.image?
      if (result = PixabayClient.new.request(node.title, per_page: 100)).valid?
        if result.images.present?
          node.image = result.images.shuffle.first.webformat_url
          puts node.image
          node.save
        end
      end
    end
  end


  def fill_up_images
    Maker::Concept.all.each do |node|
      if (result = PixabayClient.new.request(node.title, per_page: 100)).valid?
        if result.images.present?
          node.image = result.images.shuffle.first.webformat_url
          puts node.image
          node.save
        end
      end
    end
  end

end