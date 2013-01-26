# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :session do
    title "MyString"
    abstract "MyText"
    start "2013-01-26 11:34:47"
    end "2013-01-26 11:34:47"
    room "MyString"
    difficulty "MyString"
    speaker_name "MyString"
    technology "MyString"
    uri "MyText"
    event_type "MyString"
    id "MyString"
    session_lookup_id "MyText"
    speaker_uri "MyText"
  end
end
