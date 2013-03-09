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
        name "TrueFit"
      end

end
