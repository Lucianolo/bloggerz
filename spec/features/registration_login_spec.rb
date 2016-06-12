require "rails_helper"

RSpec.feature "registration_login", :type => :feature do
    
  before :each do
    User.new(:email => 'user@example.com', :password => 'password', :sign_in_count=>'1', :created_at=>"323", :updated_at=>"2131" )
  end
    
  scenario "User do login" do
    visit "/register"

    fill_in "First Name", :with => "fede"
    fill_in "Last Name", :with => "rico"
    fill_in "Profile Name", :with => "fede_rico"
    fill_in "Email", :with => "stricman@hotmail.it"
    fill_in "Password", :with => "Qwertyu1"
    fill_in "Repeat Password", :with => "Qwertyu1"
    click_button "Sign up"

    expect(page).to have_current_path(root_path)
  end
  
  scenario "wrong email" do
    visit "/register"

    fill_in "First Name", :with => "fede"
    fill_in "Last Name", :with => "rico"
    fill_in "Profile Name", :with => "fede_rico"
    fill_in "Email", :with => "stricmanhotmail.it"
    fill_in "Password", :with => "Qwertyu1"
    fill_in "Repeat Password", :with => "Qwertyu1"
    click_button "Sign up"

    expect(page).to have_content "Email is invalid"
  end
  
  scenario "wrong password" do
    visit "/register"

    fill_in "First Name", :with => "fede"
    fill_in "Last Name", :with => "rico"
    fill_in "Profile Name", :with => "fede_rico"
    fill_in "Email", :with => "stricmanhotmail.it"
    fill_in "Password", :with => "Qwert1"
    fill_in "Repeat Password", :with => "Qwert1"
    click_button "Sign up"

    expect(page).to have_content "Password is too short (minimum is 8 characters)"
  end
  
  scenario "wrong confirmation" do
    visit "/register"

    fill_in "First Name", :with => "fede"
    fill_in "Last Name", :with => "rico"
    fill_in "Profile Name", :with => "fede_rico"
    fill_in "Email", :with => "stricmanhotmail.it"
    fill_in "Password", :with => "Qwertui1"
    fill_in "Repeat Password", :with => "Qwertuu1"
    click_button "Sign up"

    expect(page).to have_content "Password confirmation doesn't match Password"
  end
  
  scenario "wrong profile name" do
    visit "/register"

    fill_in "First Name", :with => "fede"
    fill_in "Last Name", :with => "rico"
    fill_in "Profile Name", :with => "fede rico"
    fill_in "Email", :with => "stricmanhotmail.it"
    fill_in "Password", :with => "Qwertui1"
    fill_in "Repeat Password", :with => "Qwertuu1"
    click_button "Sign up"

    expect(page).to have_content "Profile name Must be formatted correctly."
  end
  
  
end