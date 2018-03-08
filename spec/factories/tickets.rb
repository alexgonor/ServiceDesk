FactoryBot.define do
  factory :ticket do
    status_of_ticket 0
    type_of_ticket 1
    title '1234567890'
    detailed_description '1234567890 1234567890'
    responsible_unit 1
    executor 1
    deadline '010119'
    history 'MyText'
    attachment 'MyString'
  end
end
