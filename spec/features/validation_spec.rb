require "rails_helper"

RSpec.feature "registration_login", :type => :feature do

    
  scenario "wrong add" do
    visit "/books/new"

    expect(page).to have_content "You need to sign in or sign up before continuing."
  end
  
  scenario "wrong users" do
    visit "/users"

    expect(page).to have_content "You need to sign in or sign up before continuing."
  end
  
  scenario "wrong user_friendships" do
    visit "/user_friendships"

    expect(page).to have_content "You need to sign in or sign up before continuing."
  end
  
  scenario "wrong conversation_messages" do
    visit "/conversation_messages"

    expect(page).to have_content "You need to sign in or sign up before continuing."
  end
  
  scenario "wrong new_conversation" do
    visit "/new_conversation"

    expect(page).to have_content "You need to sign in or sign up before continuing."
  end
  
  scenario "wrong conversation" do
    visit "/conversation"

    expect(page).to have_content "You need to sign in or sign up before continuing."
  end

  
  scenario "wrong location" do
    visit "/devise/sessions/create"

    expect(page).to have_content "Invalid email or password."
  end
end