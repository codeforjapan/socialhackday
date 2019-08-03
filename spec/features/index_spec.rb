describe "home page", type: :feature do
  before do
    visit "/"
  end

  it "displays the correct heading" do
    expect(page).to have_selector("h2", text: "Hack the social issues")
  end
end
