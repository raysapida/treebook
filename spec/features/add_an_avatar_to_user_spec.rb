require 'rails_helper'

describe 'adding an avatar', :type => :feature do
  it 'with a signed in user' do
    user = create(:user)
    status = create(:status, user: user)

    visit root_path
    fill_in 'Email', :with => user.email
    fill_in 'Password', :with => user.password
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully'

    click_link user.full_name
    expect(page).to have_content 'About Me'
    expect(page).to have_content 'Update Password'
    expect(page).to have_content 'Confirm Changes'

    fill_in 'Current password', :with => user.password
    attach_file('user[avatar]',
                "#{Rails.root}/spec/images/rails.png")
    click_button 'Update'
    expect(page).to have_content 'Your account has been updated successfully.'

    expect(page).to have_content user.full_name
    src = "#{Rails.root}/spec/images/rails.png"
    page.has_xpath?("//img[contains(@src,\"/images/#{src}\")]")

    find('img.avatar').click
    # Add expectations to this once profile view is more developed
  end
end
