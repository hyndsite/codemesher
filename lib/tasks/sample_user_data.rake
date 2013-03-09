namespace :db do
    desc "Fill database with sample data"
    task populate: :environment do
        User.create!(name: "Max McCarty",
                            email: "max.mccarty@verizon.net",
                            password: "password",
                            password_confirmation: "password")
        99.times do |n|
            name = Faker::Name.name
            email = "example-#{n+1}@myapp.com"
            password = "password"
            User.create(name: name,
                               email: email,
                               password: password,
                               password_confirmation: password)
        end

        roles = %w[admin attendee]
        roles.each do |role|
            Role.create!(name: role)
        end
    end
end
