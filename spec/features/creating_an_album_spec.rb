require 'rails_helper'

describe 'creating an album', type: :feature do
  it 'with a signed in user' do
    user = create(:user)
    visit root_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully'

    click_link 'Albums'
    expect(page).to have_content 'Listing albums'

    click_link 'New Album'
    fill_in 'Title', with: 'Testing album'
    click_button 'Create Album'
    expect(page).to have_content 'Album was successfully created.'

    click_link 'Add Picture'
    expect(page).to have_content 'New picture'

    attach_file('picture[asset]',
                "#{Rails.root}/spec/images/rails.png")
    fill_in 'picture[caption]', with: 'test image'
    fill_in 'picture[description]', with: 'Picture of rails logo'
    click_button 'Create Picture'
    expect(page).to have_content 'Picture was successfully created.'
    expect(page).to have_content 'Testing album'

    click_link 'View full size'
    expect(page).to have_content 'test image'
    expect(page).to have_content 'Picture of rails logo'
  end
end
