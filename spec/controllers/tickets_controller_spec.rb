require "rails_helper"

RSpec.describe TicketsController, type: :controller do
  describe "GET #index" do
    it "has a 302 status code" do
      get :index
      expect(response).to have_http_status(:found)
    end
  end

  describe "POST #create" do
    # let(:current_user) { FactoryBot.create :user }

    before do
      @current_user = FactoryBot.create :user
      sign_in @current_user
      post :create, params: {
        ticket: {
            title: "I broke my keyboard",
            detailed_description: "My keyboard not working. Help me!",
            type_of_ticket: :repaire,
            responsible_unit: :repair,
            deadline: Date.today,
            attachment: Rack::Test::UploadedFile.new(File.join("spec", "support", "files", "test_image.jpg"))
        }
      }
    end

    it "should response success" do
      expect(response).to have_http_status(302)
      expect(response.content_type).to eq("text/html")
    end

    it "should create new ticket" do
      ticket = @current_user.tickets.last
      expect(@current_user.tickets.count).to eq(1)
      expect(ticket.title).to eq("I broke my keyboard")
      expect(ticket.detailed_description).to eq("My keyboard not working. Help me!")
      expect(ticket.type_of_ticket).to eq("repaire")
      expect(ticket.responsible_unit).to eq("repair")
      expect(ticket.deadline).to eq(Date.today)
    end
  end
end
