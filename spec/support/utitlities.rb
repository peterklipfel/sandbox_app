def full_title(page_title)
  base_title = "Sandbox App"
  if page_title.empty?
    base_title
  else
    "#{base_title} | #{page_title}"
  end
end

def check_h1_title(h1, title)
	it { should have_selector('h1', :text => h1)}
  it { should have_selector('title', :text => title)}
end

def sign_in(user)
	visit(signin_path)
	fill_in :email, with: 	 user.email
	fill_in :password, with: user.password
	click_button 'Sign In'
	# the following line is used in case the testing environment
	# is not using capybara
	cookies[:login_token] = user.login_token
end