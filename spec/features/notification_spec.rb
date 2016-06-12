require "rails_helper"

RSpec.feature "Notification", :type => :feature do

  scenario "Send Swap rquest" do
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
    
    click_button "Create Book"
    
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
    
    visit "/books/new"
    
    fill_in "ISBN", :with => "8845292614"
    
    click_button "Create Book"
    
    click_link "Log Out"
    
    visit "/login"
    
    fill_in "email", :with => "stricman@hotmail.it"
    fill_in "password", :with => "Qwertyu1"
    
    click_button "Log In"
    
    click_link "Friends"
    
    click_link "Accept"
    
    visit "/books"
    
    click_button "Submit"
    
    
    
    expect(page).to have_content "You have sent a Book swap request"
   end
   
   scenario "view Swap rquest" do
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
    
    click_button "Create Book"
    
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
    
    visit "/books/new"
    
    fill_in "ISBN", :with => "8845292614"
    
    click_button "Create Book"
    
    click_link "Log Out"
    
    visit "/login"
    
    fill_in "email", :with => "stricman@hotmail.it"
    fill_in "password", :with => "Qwertyu1"
    
    click_button "Log In"
    
    click_link "Friends"
    
    click_link "Accept"
    
    visit "/books"
    
    click_button "Submit"
    
    click_link "Log Out"
    
    visit "/login"
    
    fill_in "email", :with => "stricman1@hotmail.it"
    fill_in "password", :with => "Qwertyu11"
    
    click_link "Notifications"
    
    click_link "1 Swaps"
   end
   
end