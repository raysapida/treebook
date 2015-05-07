require 'rails_helper'

describe "the signin process", :type => :feature do
  it "works with a valid user" do
    user = create(:user)
    visit login_path
    fill_form(:user, :new, { email: user.email, password: user.password})
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully'
  end
end
