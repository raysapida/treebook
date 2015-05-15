require 'rails_helper'

describe 'using admin interface', type: :feature do
  it 'with a signed in user that is not an admin' do
    user = create(:user)

    visit root_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully'

    expect(page).to_not have_content 'Admin'
  end

  it 'with a signed in user that is an admin' do
    user = create(:user, email: 'admin@example.com')

    visit root_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully'
    expect(page).to have_content 'Admin'

    click_link 'Admin'
    expect(page).to have_content 'Dashboard'

    click_link 'Users'
    expect(page).to have_content user.full_name
  end
end
