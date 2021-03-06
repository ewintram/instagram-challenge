require 'rails_helper'

RSpec.feature "editing posts", type: :feature do
  before(:each) do
    sign_up(email: "ellie@example.com", username: "ewintram", password: "password123", password_confirmation: "password123")
    create_post(caption: "#basic")
    visit "/"
  end

  scenario "User can edit a post" do
    find(:xpath, "//a[contains(@href,'posts/10')]").click
    click_on "edit"
    fill_in "post[caption]", with: "Edited caption"
    click_on "Update Post"

    expect(page).to have_content("Post updated")
    expect(page).to have_content("Edited caption")
    expect(page).not_to have_content("Chihuahua... or blueberry muffin?")
  end

  scenario "User cannot edit a post with a non-image file" do
    find(:xpath, "//a[contains(@href,'posts/11')]").click
    click_on "edit"
    attach_file("post[image]", "spec/files/images/test.xlsx")
    click_on "Update Post"

    expect(page).to have_content("Invalid file. Only image files can be uploaded")
  end

  scenario "User can only edit their own posts" do
    click_on "sign out"
    sign_up(email: "david@example.com", username: "dwright", password: "password123", password_confirmation: "password123")
    visit "/"
    find(:xpath, "//a[contains(@href,'posts/12')]").click

    expect(page).not_to have_content "edit"
  end
end
