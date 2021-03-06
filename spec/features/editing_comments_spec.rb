require 'rails_helper'

RSpec.feature "editing comments", type: :feature do

  before do
    sign_up(email: "ellie@example.com", username: "ewintram", password: "password123", password_confirmation: "password123")
    create_post(caption: "Y tho")
    create_comment(comment: "Nice pic")
  end

  scenario "User can edit comments" do
    click_on "edit comment"
    fill_in "comment[comment]", with: "Edited comment"
    click_on "Update Comment"

    expect(page).to have_content("Comment updated")
    expect(page).to have_content("Edited comment")
    expect(page).not_to have_content("Nice pic")
  end

  scenario "User can only edit their own comments" do
    click_on "sign out"
    sign_up(email: "david@example.com", username: "dwright", password: "password123", password_confirmation: "password123")
    visit "/"
    find(:xpath, "//a[contains(@href,'posts/9')]").click

    expect(page).not_to have_content "edit comment"
  end
end
