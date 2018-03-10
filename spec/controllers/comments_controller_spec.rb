require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  describe 'POST #create' do
    let(:current_user) { FactoryBot.create :comment }
    before do
      @current_user = FactoryBot.create :user
      sign_in @current_user
      post :create, params: {
        comment: {
          content: 'Good long enough comment'
        }
      }
    end

    it 'should response success' do
      expect(response).to have_http_status(302)
      expect(response.content_type).to eq('text/html')
    end

    it 'should create new comment' do
      comment = @current_user.ticket.comments.last
      expect(@current_user.ticket.comments.count).to eq(1)
      expect(comment.content).to eq('Good long enough comment')
    end
  end

  describe '#destroy' do
    context 'existing comment' do
      let!(:comment) { FactoryBot.create(:comment) }

      it 'removes comment from table' do
        expect { delete :destroy, params: { id: comment } }.to change { Comment.count }.by(-1)
      end

      it 'renders index template' do
        delete :destroy, params: { id: comment }
        expect(response).to render_template('index')
      end
    end
  end
end
