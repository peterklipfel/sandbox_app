module SessionsHelper

	def sign_in(user)
		cookies.permanent[:login_token] = user.login_token
		self.current_user = user
	end

	def current_user=(user)
		@current_user = user
	end

	def current_user
		@current_user ||= User.find_by_login_token(cookies[:login_token])
	end

	def signed_in?
		!current_user.nil?
	end
	
end
