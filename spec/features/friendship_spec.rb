require "rails_helper"

RSpec.feature "friendship", :type => :feature do

    
  scenario "User send a friendship request" do
    visit "/register"

    fill_in "First Name", :with => "mario"
    fill_in "Last Name", :with => "rossi"
    fill_in "Profile Name", :with => "marioRossi"
    fill_in "Email", :with => "stricman@hotmail.it"
    fill_in "Password", :with => "Qwertyu1"
    fill_in "Repeat Password", :with => "Qwertyu1"
    click_button "Sign up"

    visit "/books/new"
    
    fill_in "ISBN", :with => "9780439023528"
    
    click_link "Log Out"
    
    visit "/register"

    fill_in "First Name", :with => "fede"
    fill_in "Last Name", :with => "rico"
    fill_in "Profile Name", :with => "federico"
    fill_in "Email", :with => "stricman1@hotmail.it"
    fill_in "Password", :with => "Qwertyu11"
    fill_in "Repeat Password", :with => "Qwertyu11"
    click_button "Sign up"

    visit "/user_friendships/new?friend_id=marioRossi"
    
    click_button "Yes, add Friend"
    

    expect(page).to have_content "You have sent a friends request to Mario Rossi"
  end
  
  scenario "User accept a friendship request" do
    visit "/register"

    fill_in "First Name", :with => "mario"
    fill_in "Last Name", :with => "rossi"
    fill_in "Profile Name", :with => "marioRossi"
    fill_in "Email", :with => "stricman@hotmail.it"
    fill_in "Password", :with => "Qwertyu1"
    fill_in "Repeat Password", :with => "Qwertyu1"
    click_button "Sign up"

    visit "/books/new"
    
    fill_in "ISBN", :with => "9780439023528"
    
    click_link "Log Out"
    
    visit "/register"

    fill_in "First Name", :with => "fede"
    fill_in "Last Name", :with => "rico"
    fill_in "Profile Name", :with => "federico"
    fill_in "Email", :with => "stricman1@hotmail.it"
    fill_in "Password", :with => "Qwertyu11"
    fill_in "Repeat Password", :with => "Qwertyu11"
    click_button "Sign up"

    visit "/user_friendships/new?friend_id=marioRossi"
    
    click_button "Yes, add Friend"
    
    click_link "Log Out"
    
    visit "/login"
    
    fill_in "email", :with => "stricman@hotmail.it"
    fill_in "password", :with => "Qwertyu1"
    
    click_button "Log In"
    
    click_link "Friends"
    
    click_link "Accept"
    
    expect(page).to have_content "Congratulations, you have a new friend!"

  end
  
  scenario "User reject a friendship request" do
    visit "/register"

    fill_in "First Name", :with => "mario"
    fill_in "Last Name", :with => "rossi"
    fill_in "Profile Name", :with => "marioRossi"
    fill_in "Email", :with => "stricman@hotmail.it"
    fill_in "Password", :with => "Qwertyu1"
    fill_in "Repeat Password", :with => "Qwertyu1"
    click_button "Sign up"

    visit "/books/new"
    
    fill_in "ISBN", :with => "9780439023528"
    
    click_link "Log Out"
    
    visit "/register"

    fill_in "First Name", :with => "fede"
    fill_in "Last Name", :with => "rico"
    fill_in "Profile Name", :with => "federico"
    fill_in "Email", :with => "stricman1@hotmail.it"
    fill_in "Password", :with => "Qwertyu11"
    fill_in "Repeat Password", :with => "Qwertyu11"
    click_button "Sign up"

    visit "/user_friendships/new?friend_id=marioRossi"
    
    click_button "Yes, add Friend"
    
    click_link "Log Out"
    
    visit "/login"
    
    fill_in "email", :with => "stricman@hotmail.it"
    fill_in "password", :with => "Qwertyu1"
    
    click_button "Log In"
    
    click_link "Friends"
    
    click_link "Decline"

  end
  
end