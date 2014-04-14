module ApplicationHelper
 def logged_in?
    !!session[:user_id]
  end

  def correct_user
    User.find(session[:user_id]) if logged_in?
  end
end
