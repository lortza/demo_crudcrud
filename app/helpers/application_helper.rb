module ApplicationHelper

  def login_links
    if signed_in_user?
      str = "Welcome, #{link_to(current_user.name, current_user)}!" +
            link_to("Logout", logout_path, :method => :delete)
    else
      str = link_to "Login", login_path
    end
    str.html_safe
  end

end
