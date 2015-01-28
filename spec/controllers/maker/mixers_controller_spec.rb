require 'rails_helper'


class TestNode
  include Neo4j::ActiveNode
  property :title
end


RSpec.describe Maker::MixersController, :type => :controller do

  let(:subject_node) { TestNode.create(title: 'pear') }
  let(:object_node)  { TestNode.create(title: 'fruit') }


  describe "POST create" do
    it "creates a new node when supplied valid data" do
      post :create, cardtec_message: valid_data(subject_node, object_node)

      expect(response).to be_success
      expect(assigns(:relationship).start_node).to eq assigns(:subject_node)
      expect(assigns(:relationship).end_node).to eq assigns(:object_node)
      expect(assigns(:relationship).rel_type).to eq :is_a
      expect(assigns(:subject_node).rels.count).to eq 1
    end
  end


  def valid_data(subject_node, object_node)
    <<-"END".gsub(/^ {6}/, '')
      <div class="connector" itemscope="" itemtype="http://dingdealer.de/maker/mixer">
        <div class="subject">
          <h4>
            <data itemprop="subject_uuid" value="#{subject_node.uuid}">Baum</data>
          </h4>
        </div>
        <div class="predicate" itemprop="predicate_title">
          <button class="large relationship_type active">is_a</button>
        </div>
        <div class="object">
          <h4>
            <data itemprop="object_uuid" value="#{object_node.uuid}">
              Bagger
            </data>
          </h4>
        </div>
      <div>
    END
  end


end
