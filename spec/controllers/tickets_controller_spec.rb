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

  describe "POST #create" do
    let(:current_user){ create :user }

    before do
      sign_in current_user
      post :create, params: {
        ticket: {
            title: "I broke my keyboard",
            detailed_description: "My keyboard not working. Help me!",
            type_of_ticket: :repaire,
            responsible_unit: :repair,
            deadline: Date.today,
        }}
    end

    it "should response success" do
      expect(response).to have_http_status(200)
      expect(response.content_type).to eq("application/html")
    end

    it "should create new ticket" do
      ticket = user.tickets.last
      expect(user.tickets.count).to eq(1)
      expect(ticket.title).to eq("I broke my keyboard")
      expect(ticket.detailed_description).to eq("My keyboard not working. Help me!")
      expect(ticket.type_of_ticket).to eq(:repaire)
      expect(ticket.responsible_unit).to eq(:repaire)
      expect(ticket.deadline).to eq(Date.today)
    end
  end
end
