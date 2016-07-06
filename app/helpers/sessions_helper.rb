module SessionsHelper

  # writes a cookie in the response back to the user with the remember_token.  this indicates the user has been auth'ed.
  #
  # however, this raises an interesting question - is this enough to prove that the user has been authenticated?
  # what if someone hijacked another's auth cookie?
  #
  # this is something to consider.  how could we mitigate this?
  #
  def sign_in(user)
    cookies[:remember_token] = user.remember_token
  end
  
  # now, all we need to check is if the user has the 'remember_token' cookie
  #
  # however, this doesn't really prove that the user has logged in - you can go into the dev tools in chrome
  # and fake the cookie and give it a bogus value.  a proper check would be to also see if the remember_token is valid
  # but do we want to hit our database every time we need to check if the user is signed in?
  def signed_in?
    !cookies[:remember_token].nil?
  end

  def current_user
    User.find_by_remember_token(cookies[:remember_token])
  end

  # since we're using cookies to determine whether or not the user is authorized - all we need to do here is
  # delete the cookie.
  def sign_out
    cookies.delete(:remember_token)
  end
end
