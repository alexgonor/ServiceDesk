require "rails_helper"

RSpec.describe TicketsController, type: :controller do
  describe "GET #index" do
    it "has a 302 status code" do
      get :index
      expect(response).to have_http_status(:found)
    end
  end

  describe "PUT update" do
    before :each do
      @ticket = FactoryBot.create(:ticket)
    end

    it "located the requested @ticket" do
      put :update, params: { id: @ticket, ticket: FactoryBot.attributes_for(:ticket) }
      assigns(:ticket).should eq(@ticket)
    end

    it "changes @ticket's attributes" do
      put :update, params: { id: @ticket, ticket: FactoryBot.attributes_for(:ticket) }
      @ticket.reload
      @ticket.title.should eq("1234567890")
      @ticket.detailed_description.should eq("1234567890 1234567890")
      @ticket.type_of_ticket.should eq("service_request")
      @ticket.status_of_ticket.should eq("newly_created")
      @ticket.responsible_unit.should eq("service")
    end
  end
end
