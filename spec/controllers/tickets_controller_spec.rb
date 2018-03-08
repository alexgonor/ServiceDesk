require 'rails_helper'

RSpec.describe TicketsController, type: :controller do
  describe 'GET #index' do
    it 'has a 302 status code' do
      get :index
      expect(response).to have_http_status(:found)
    end
  end

  describe 'PUT update' do
    before :each do
      @ticket = FactoryBot.create(:ticket)
    end

    it 'located the requested @ticket' do
      put :update, params: { id: @ticket, ticket: FactoryBot.attributes_for(:ticket) }
      assigns(:ticket).should eq(@ticket)
    end

    it "changes @ticket's attributes" do
      put :update, params: { id: @ticket, ticket: FactoryBot.attributes_for(:ticket) }
      @ticket.reload
      @ticket.title.should eq('1234567890')
      @ticket.detailed_description.should eq('1234567890 1234567890')
      @ticket.type_of_ticket.should eq('service_request')
      @ticket.status_of_ticket.should eq('newly_created')
      @ticket.responsible_unit.should eq('service')
    end
  end

  describe 'POST #create' do
    let(:current_user) { FactoryBot.create :user }
    before do
      @current_user = FactoryBot.create :user
      sign_in @current_user
      post :create, params: {
        ticket: {
          title: 'I broke my keyboard',
          detailed_description: 'My keyboard not working. Help me!',
          type_of_ticket: :repaire,
          responsible_unit: :repair,
          deadline: Date.today,
          attachment: Rack::Test::UploadedFile.new(File.join('spec', 'support', 'files', 'test_image.jpg'))
        }
      }
    end

    it 'should response success' do
      expect(response).to have_http_status(302)
      expect(response.content_type).to eq('text/html')
    end

    it 'should create new ticket' do
      ticket = @current_user.tickets.last
      expect(@current_user.tickets.count).to eq(1)
      expect(ticket.title).to eq('I broke my keyboard')
      expect(ticket.detailed_description).to eq('My keyboard not working. Help me!')
      expect(ticket.type_of_ticket).to eq('repaire')
      expect(ticket.responsible_unit).to eq('repair')
      expect(ticket.deadline).to eq(Date.today)
    end
  end

  describe '#destroy' do
    context 'existing ticket' do
      let!(:ticket) { FactoryBot.create(:ticket) }

      it 'removes ticket from table' do
        expect { delete :destroy, params: { id: ticket } }.to change { Ticket.count }.by(-1)
      end

      it 'renders index template' do
        delete :destroy, params: { id: ticket }
        expect(response).to render_template('index')
      end
    end

    context 'delete a non-existent ticket' do
      it 'creates an error message' do
        delete :destroy, params: { id: 10_000 }
        expect(flash[:warning]).to include("Ticket doesn't exist")
      end
    end
  end
end
