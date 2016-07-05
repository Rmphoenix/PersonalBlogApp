module SessionsHelper
  
  def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token
    self.current_user = user
  end
  
  # exclamation denotes 'not', or, in context to the line of code below, 
  # not nil.  Not nil returns true
  def signed_in?
    !current_user.nil?
  end
  
  # '=' in a method is strange but it defines a method current_user = expressly
  # designed to handle assignment to the current_user
  
  def current_user=(user)
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end
  
  # '||=' translates to ("or equals")
  # basically returns @current_user ORRRRR if there is none is returns the latter part
  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end
  
  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end
end
