module SessionsHelper

	def sign_in(user)
		cookies.permanent[:login_token] = user.login_token
		self.current_user = user
	end

	def sign_out
		self.current_user = nil
		cookies.delete(:login_token)
	end

	def current_user=(user)
		@current_user = user
	end

	def current_user
		@current_user ||= User.find_by_login_token(cookies[:login_token])
	end

	def current_user?(user)
		current_user == user
	end

	def signed_in?
		!current_user.nil?
	end

	def save_attempted_uri
		session[:redirect] = request.fullpath
	end

	def redirect_to_desired_uri(default)
		redirect_to(session[:redirect] || default)
		session.delete(:redirect)
	end
end
