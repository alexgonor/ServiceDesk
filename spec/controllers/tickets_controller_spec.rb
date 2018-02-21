require "rails_helper"

RSpec.describe TicketsController, type: :controller do
  describe "GET #index" do
    it "has a 302 status code" do
      get :index
      expect(response).to have_http_status(:found)
    end
  end
end
