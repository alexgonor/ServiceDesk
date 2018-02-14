FactoryBot.define do
  factory :ticket do
    status 1
    type 1
    title "MyString"
    detailed_description "MyText MyText"
    responsible_unit 1
    author 1
    executor 1
    deadline "2018-02-14"
    history "MyText"
    attachment "MyString"
  end
end
