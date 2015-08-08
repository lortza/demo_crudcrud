require 'rails_helper'

describe "users/index.html.erb" do

  it "shows the User's first name" do
    user = create(:user)
    users = [user, create(:user)]

    # set the instance variable
    # could be done implicitly if we just used an
    # instance variable above, e.g. `@users`
    assign(:users, users) 

    # render the view
    render

    # Check that it contains our user's first name

    # ... HTML style
    expect(rendered).to match('<h1>users index</h1>')

    # ... CSS style
    expect(rendered).to have_selector("a[href=\"#{user_path(user)}\"]", :text => "Show #{user.name}")
  end

end