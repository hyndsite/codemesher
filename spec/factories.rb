FactoryGirl.define do
      factory :user do
          sequence(:name) {|n| "Person #{n}"}
          sequence(:email) {|n| "example_#{n}@overtherainbow.com"}
          password "password"
          password_confirmation "password"

          factory :attendee do
              after(:create) do |user|
                  user.roles = [FactoryGirl.create(:attendee_role)]
              end
          end

          trait :with_admin_group do
            after(:create) do |user|
               user.memberships = [FactoryGirl.create(:as_admin, user: user),
                                              FactoryGirl.create(:membership, user: user)]
          end
      end
      end

      factory :role do
          factory :admin_role do
            name "admin"
            initialize_with {Role.find_or_create_by_name(:admin)}
          end
          factory :attendee_role do
            name "attendee"
            initialize_with {Role.find_or_create_by_name(:attendee)}
          end
          factory :new_role do
            name "new_role"
          end
      end

      factory :group do
        sequence(:name) {|n| "#{n} Group"}
      end

      factory :membership do
        association :group
        association :user

        factory :as_admin do
          owner = true
          contributor = true
        end

        factory :as_contributor do
          owner = false
          contributor = true
        end
      end

      factory :speaker do
       sequence(:name) {|n| "Speaker #{n}"}
        sequence(:biography) {|n|"Biography of speaker #{n}"}
        sequence(:blog_url) {|n| "http://Someurl.com" }
        sequence(:email_address) {|n| "speaker#{n}@example.com"}
        sequence(:twitter){|n| "@speaker#{n}"}
      end

      factory :session do
        sequence(:abstract) {|n| "Short description for session #{n}"}
        start = Time.new(2014, 1, 15, 9, 0)
        finish = Time.new(2014, 1, 15, 10, 0)
        level = ["Beginner", "Intermediate", "Advanced"][Random.new.rand(0..2)]
        sequence(:room) {|n| "R#{n}"}
        sequence(:title) {|n| "Some Random Course # #{n}"}

        association :speaker
      end
end
