
require 'rails_helper'

describe 'interacting with user friendship', type: :feature do
  it 'signed in user can request friendship' do
    user = create(:user)
    status = create(:status)
    visit root_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully'

    click_link 'All Statuses'
    expect(page).to have_content status.content

    click_link(status.user.profile_name)
    expect(page).to have_content 'Add Friend'

    click_link 'Add Friend'
    expect(page).to have_content "Do you really want to friend #{status.user.full_name}?"

    click_button 'Yes, Add Friend'
    expect(page).to have_content 'Friend request sent'
  end
end
