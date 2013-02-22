def sign_in(user)
  visit signin_path
  fill_in "Email", with: user.email.upcase
  fill_in "Password", with: user.password
  click_button "Sign in"
  cookies[:remember_token] = user.remember_token
end

def app_title(page_title)
  base_title = "CodeMesher:  Mesh your CodeMash Experience"

  if (page_title.empty?)
    base_title
  else
    "#{base_title} | #{page_title}"
  end
end
