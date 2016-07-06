module SessionsHelper

  # http://www.justinweiss.com/articles/how-rails-sessions-work/
  # ^ read this.  basically, you want to use the session object for this.
  # my understanding is the session object is a rails-managed cookie that
  # gets stored in the user side, and is way more secure than writing to cookies
  # directly (for the most part)
  def sign_in(user)
    session[:remember_token] = user.remember_token
  end

  def signed_in?
    !session[:remember_token].nil?
  end

  def current_user
    User.find_by_remember_token(session[:remember_token])
  end

  def sign_out
    session.delete(:remember_token)
  end
end
