class CreateAutoImageForNode

  def node_saved(node, me_current)
    node_klass = node.try(:neo_ruby_klass) || node.class
    if node.is_a?(Maker::App) && node.respond_to?(:image) && !node.image?
      if (result = PixabayClient.new.request(node.title, per_page: 100)).valid?
        if result.images.present?
          node.remote_image_url = result.images.shuffle.first.webformat_url
          node.image_will_change!
          node.save
        end
      end
    end
  end


  def fill_up_images
    Maker::Concept.all.each do |node|
      if (result = PixabayClient.new.request(node.title, per_page: 100)).valid?
        if result.images.present?
          node.remote_image_url = result.images.shuffle.first.webformat_url
          node.image_will_change!
          node.save
          puts node.image.to_s
        end
      end
    end
    nil
  end

# Maker::Concept.all.each { |c| c.image.recreate_versions! rescue next  }

end