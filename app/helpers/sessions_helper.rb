module SessionsHelper

  # when we sign in, all we really want to do is store the user's remember_token as a set of cookies that our server
  # remembers.  currently i don't know if there's a point to using @variables, since it appears that every
  # page gets a new session object, requiring us to re-fetch the user using User.find_by_remember_token
  def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token
  end
  
  # signed_in will just check to see if we can find a user with the remember_token we're looking for.
  def signed_in?
    !self.current_user.nil?
  end

  # let's have self.current_user call User.find_by_remember_token.  if we can't find it, we return nil.
  def current_user
    User.find_by_remember_token(cookies[:remember_token])
  end

  # signing out just deletes the rememeber_token from the cookies that our server is aware of.
  # then, when anything else calls current_user, it will return nil because we've deleted the cookie we'd be looking for.
  def sign_out
    cookies.delete(:remember_token)
  end
end
