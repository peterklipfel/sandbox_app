namespace :db do
	desc 'Fill in database with sample data'
	task populate: :environment do 
		admin = User.create!(name: "Admin User",
                         email: "admin@user.org",
                         password: "areasonablepassword",
                         password_confirmation: "areasonablepassword")
    admin.toggle!(:admin)

		User.create(:name => 'Unique Sample', 
								:email => 'heres@nem.ail',
								:password => 'areasonablepassword',
								:password_confirmation => 'areasonablepassword')
		
		99.times do |u|
			name = Faker::Name.name
			email = "example-#{u+1}@takaria.mix"
      password  = "password"
      User.create!(:name => name,
      						 :email => email,
      						 :password => password,
      						 :password_confirmation => password)
    end
  end
end
