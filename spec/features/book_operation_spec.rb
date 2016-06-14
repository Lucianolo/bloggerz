require "rails_helper"

RSpec.feature "book_operation", :type => :feature do

    
  scenario "User add a book" do
    visit "/register"

    fill_in "First Name", :with => "fede"
    fill_in "Last Name", :with => "rico"
    fill_in "Profile Name", :with => "fede_rico"
    fill_in "Email", :with => "stricman@hotmail.it"
    fill_in "Password", :with => "Qwertyu1"
    fill_in "Repeat Password", :with => "Qwertyu1"
    click_button "Sign up"
    
    

    visit "/books/new"
    
    fill_in "ISBN", :with => "9780439023528"
    
    click_button "Create Book"
    
    expect(page).to have_content "Book was successfully created."
  end
  
  scenario "User add a duplicate book" do
    visit "/register"

    fill_in "First Name", :with => "fede"
    fill_in "Last Name", :with => "rico"
    fill_in "Profile Name", :with => "fede_rico"
    fill_in "Email", :with => "stricman@hotmail.it"
    fill_in "Password", :with => "Qwertyu1"
    fill_in "Repeat Password", :with => "Qwertyu1"
    click_button "Sign up"

    visit "/books/new"
    
    fill_in "ISBN", :with => "9780439023528"
    
    click_button "Create Book"
    
    visit "/books/new"
    
    fill_in "ISBN", :with => "9780439023528"
    
    click_button "Create Book"
    
    expect(page).to have_content "You already added this book, check your Books list!"
  end
 
  scenario "User like a book" do
    visit "/register"

    fill_in "First Name", :with => "fede"
    fill_in "Last Name", :with => "rico"
    fill_in "Profile Name", :with => "fede_rico"
    fill_in "Email", :with => "stricman@hotmail.it"
    fill_in "Password", :with => "Qwertyu1"
    fill_in "Repeat Password", :with => "Qwertyu1"
    click_button "Sign up"

    visit "/books/new"
    
    fill_in "ISBN", :with => "8845292614"
    
    click_button "Create Book"
    
    visit "/books"
    
    click_link "Like"
    
    find_button("Liked")
  end
  
  scenario "User dislike a book" do
    visit "/register"

    fill_in "First Name", :with => "fede"
    fill_in "Last Name", :with => "rico"
    fill_in "Profile Name", :with => "fede_rico"
    fill_in "Email", :with => "stricman@hotmail.it"
    fill_in "Password", :with => "Qwertyu1"
    fill_in "Repeat Password", :with => "Qwertyu1"
    click_button "Sign up"

    visit "/books/new"
    
    fill_in "ISBN", :with => "8845292614"
    
    click_button "Create Book"
    
    visit "/books"
    
    click_link "Dislike"
    
    find_button("Disliked")
  end

    scenario "User add a comment" do
    visit "/register"

    fill_in "First Name", :with => "fede"
    fill_in "Last Name", :with => "rico"
    fill_in "Profile Name", :with => "fede_rico"
    fill_in "Email", :with => "stricman@hotmail.it"
    fill_in "Password", :with => "Qwertyu1"
    fill_in "Repeat Password", :with => "Qwertyu1"
    click_button "Sign up"

    visit "/books/new"
    
    fill_in "ISBN", :with => "8845292614"
    
    click_button "Create Book"
    
    fill_in "Add a comment...", :with => "wewe"
    click_button "submit"
    
    expect(page).to have_content "You commented the hell out of that book!"
  end
 
=begin
  scenario "User delete a comment", :js => true do
    visit "/register"

    fill_in "First Name", :with => "fede"
    fill_in "Last Name", :with => "rico"
    fill_in "Profile Name", :with => "fede_rico"
    fill_in "Email", :with => "stricman@hotmail.it"
    fill_in "Password", :with => "Qwertyu1"
    fill_in "Repeat Password", :with => "Qwertyu1"
    click_button "Sign up"

    visit "/books/new"
    
    fill_in "ISBN", :with => "9780439023528"
    
    click_button "Create Book"
    
    fill_in "Add a comment...", :with => "wewe"
    click_button "submit"
    
    
    page.accept_confirm { click_link("x") }

    
    expect(page).to have_content "Comment deleted :("
  end
=end

scenario "edit book" do
    visit "/register"

    fill_in "First Name", :with => "fede"
    fill_in "Last Name", :with => "rico"
    fill_in "Profile Name", :with => "fede_rico"
    fill_in "Email", :with => "stricman@hotmail.it"
    fill_in "Password", :with => "Qwertyu1"
    fill_in "Repeat Password", :with => "Qwertyu1"
    click_button "Sign up"
    
    visit "/books/new"
    
    fill_in "ISBN", :with => "8845292614"
    
    click_button "Create Book"
    
    click_link "Edit"
    
    click_button "Update Book"
    
    expect(page).to have_content "Book was successfully updated."
  end
  
end