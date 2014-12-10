require 'rails_helper'

RSpec.describe Modix::ConceptsController, :type => :controller do
  describe "GET index" do
    it "returns http success" do
      get :index
      expect(response).to be_success
      expect(assigns(:nodes).count).to eql(0)
    end
  end

  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to be_success
    end

    it "has a new Cardtec::Node assigned" do
      get :new
      expect(assigns(:node).class).to eql(Modix::Concept)
      expect(assigns(:node)).not_to be_persisted
    end
  end

  describe "POST create" do
    it "creates a new node when supplied valid data" do
      post :create, cardtec_node: { html: valid_data }
      expect(assigns(:node)).to be_persisted
      expect(response).to redirect_to(modix_concept_path(assigns(:node)))
    end
  end

  describe "GET show" do
    before do
      @node =  FactoryGirl.create(:node)
    end
    it "shows a previously created node" do

      get :show, id: @node.neo_id
      expect(response).to be_success
    end
  end

  def valid_data
    '<div class="cardtec_property"><div class="cardtec_property_name" contenteditable="true">ident</div><div class="cardtec_property_value" contenteditable="true"></div></div><div class="cardtec_property"><div class="cardtec_property_name" contenteditable="true">title</div><div class="cardtec_property_value" contenteditable="true"></div></div><div class="cardtec_property"><div class="cardtec_property_name" contenteditable="true">body</div><div class="cardtec_property_value" contenteditable="true"></div></div><div class="cardtec_property"><div class="cardtec_property_name" contenteditable="true">image_url</div><div class="cardtec_property_value" contenteditable="true"></div></div>
    '
  end
end
