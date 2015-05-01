require 'rails_helper'

describe "creating a status", :type => :feature do
  it "signed in user can create statuses" do
    user = create(:user)
    visit root_path
    fill_in 'Email', :with => user.email
    fill_in 'Password', :with => user.password
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully'

    click_button 'Post a New Status'
    expect(page).to have_content 'New Status Update'
    fill_in 'Content', :with => 'I hope this works'
    click_button 'Create Status'
    expect(page).to have_content 'Status was successfully created.'
    expect(page).to have_content 'I hope this works'

    click_link 'All Statuses'
    click_button 'Post a New Status'
    expect(page).to have_content 'New Status Update'
    fill_in 'Content', :with => 'A new hope'
    click_button 'Create Status'
    expect(page).to have_content 'Status was successfully created.'
    expect(page).to have_content 'I hope this works'
    expect(page).to have_content 'A new hope'
  end

  it "can upload an image" do
    pending("Need to figure out how to test paperclip's upload")
    user = create(:user)
    visit root_path
    fill_in 'Email', :with => user.email
    fill_in 'Password', :with => user.password
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully'

    click_link 'All Statuses'
    click_button 'Post a New Status'
    expect(page).to have_content 'New Status Update'
    fill_in 'Content', :with => ''
    click_button 'Create Status'
    expect(page).to have_content 'Status was successfully created.'
    expect(page).to have_content 'I hope this works'
    expect(page).to have_content 'A new hope'
  end
end
