require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { should validate_presence_of(:content) }
  it { should validate_length_of(:content).is_at_most(100) }
end
