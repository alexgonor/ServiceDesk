require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:position_in_the_company) }
  it { should validate_presence_of(:type_of_user) }
end
