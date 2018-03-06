require 'rails_helper'

# RSpec.describe Ticket, type: :model do
#  pending "add some examples to (or delete) #{__FILE__}"
# end

RSpec.describe Ticket, type: :model do
  it { should validate_length_of(:title).is_at_least(10) }
  it { should validate_length_of(:title).is_at_most(100) }
  it { should validate_presence_of(:title) }
  it { should validate_uniqueness_of(:title) }
  it { should validate_length_of(:detailed_description).is_at_least(20) }
  it { should validate_length_of(:detailed_description).is_at_most(200) }
  it { should validate_presence_of(:deadline) }
end
