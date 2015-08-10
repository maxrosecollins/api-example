require 'rails_helper'

RSpec.describe DisplayController, type: :controller do
  describe "GET #index" do
    it "returns json" do
      get :index, {}, { "Accept" => "application/json" }
      expect(response.status).to eq 200
    end

    it "renders the :index view" do
      get :index
      expect(response).to render_template :index
    end
  end
end
