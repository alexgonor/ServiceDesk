class ChatRoomsController < ApplicationController
  before_action :authenticate_user!
end
