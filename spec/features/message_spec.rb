feature "submitting form on homepage" do
  scenario "user can submit a message and see the message appear on the homepage" do
    visit "/"

    fill_in "Username", :with => "jetaggart"
    fill_in "Message", :with => "Howdy!"
    click_on "Add Message"

    expect(page).to have_content("Howdy!")
    expect(page).to have_content("jetaggart")

    #user can see messages left by other people

    visit "/"

    fill_in "Username", :with => "jess"
    fill_in "Message", :with => "Im happy!"
    click_on "Add Message"

    expect(page).to have_content("Howdy!")

  end
end

