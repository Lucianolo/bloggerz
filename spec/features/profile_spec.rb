require "rails_helper"

RSpec.feature "profile", :type => :feature do

    
  scenario "Search bar" do
    visit "/register"

    fill_in "First Name", :with => "mario"
    fill_in "Last Name", :with => "rossi"
    fill_in "Profile Name", :with => "marioRossi"
    fill_in "Email", :with => "stricman@hotmail.it"
    fill_in "Password", :with => "Qwertyu1"
    fill_in "Repeat Password", :with => "Qwertyu1"
    click_button "Sign up"
    
    fill_in "User", :with => "mario"

    
    click_link "Mario Rossi"
  end
  
  scenario "Update profile" do
    visit "/register"

    fill_in "First Name", :with => "mario"
    fill_in "Last Name", :with => "rossi"
    fill_in "Profile Name", :with => "marioRossi"
    fill_in "Email", :with => "stricman@hotmail.it"
    fill_in "Password", :with => "Qwertyu1"
    fill_in "Repeat Password", :with => "Qwertyu1"
    click_button "Sign up"
    
    visit "/marioRossi"
    
    click_link "Update Profile"
    
    expect(page).to have_css("input", :count => 9) 
    
  end
  
  scenario "Change password" do
    visit "/register"

    fill_in "First Name", :with => "mario"
    fill_in "Last Name", :with => "rossi"
    fill_in "Profile Name", :with => "marioRossi"
    fill_in "Email", :with => "stricman@hotmail.it"
    fill_in "Password", :with => "Qwertyu1"
    fill_in "Repeat Password", :with => "Qwertyu1"
    click_button "Sign up"
    
    visit "/marioRossi"
    
    click_link "Update Profile"
    
    fill_in "Email", :with => "stricman@hotmail.it"
    fill_in "Password", :with => "Qwertyu2"
    fill_in "Password confirmation", :with => "Qwertyu2"
    
    fill_in "Current password", :with => "Qwertyu1"
    
    click_button "Update"
    
    
    expect(page).to have_content "Your account has been updated successfully." 
    
  end
  
end