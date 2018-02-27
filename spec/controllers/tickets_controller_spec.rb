require "rails_helper"

RSpec.describe TicketsController, type: :controller do
  describe "GET #index" do
    it "has a 302 status code" do
      get :index
      expect(response).to have_http_status(:found)
    end
  end

  describe "POST #create" do
    let(:current_user){ create :user }

    before do
      sign_in current_user
      post :create, params: {
        author: "test",
        title: "test",
        detailed_description: "test",
        type_of_ticket: "test",
        responsible_unit: "test",
        deadline: "test",
        avatar: "test"
      }
    end

    it "should response success" do
      expect(response).to have_http_status(200)
      expect(response.content_type).to eq("application/html")
    end

    it "should create new ticket" do
      ticket = user.tickets.last
      expect(user.tickets.count).to eq(1)
      expect(ticket.author).to eq("test")
      expect(ticket.title).to eq("test")
      expect(ticket.detailed_description).to eq("test")
      expect(ticket.type_of_ticket).to eq("test")
      expect(ticket.responsible_unit).to eq("test")
      expect(ticket.deadline).to eq("test")
      expect(ticket.avatar).to eq("test")
    end
  end
end
