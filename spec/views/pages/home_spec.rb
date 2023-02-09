require "rails_helper"

RSpec.describe "pages/home", type: :view do
  it "displays the home page" do
    render
    expect(rendered).to match /Runa/
  end
end
