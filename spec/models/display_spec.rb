require 'rails_helper'

RSpec.describe Display, type: :model do
  before do
    @api = Display.new
  end
  describe "#qualifications" do
    before do
      @qualifications = JSON.parse(@api.qualifications)
    end

    it "returns Array" do
      expect(@qualifications.class).to eq Array
    end
  end

  describe "#base_path" do
    it "returns API path" do
      expect(@api.base_path).to eq "/api/v4/"
    end
  end

  describe "#cache" do
    it "returns a string" do
      @api.cache("gojimo:4"){"my string"}
      assert_equal("my string", @api.cache("gojimo:4"))
    end
  end

end
