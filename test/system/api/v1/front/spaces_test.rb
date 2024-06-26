require "application_system_test_case"

class Api::V1::Front::SpacesTest < ApplicationSystemTestCase
  setup do
    @api_v1_front_space = api_v1_front_spaces(:one)
  end

  test "visiting the index" do
    visit api_v1_front_spaces_url
    assert_selector "h1", text: "Api/V1/Front/Spaces"
  end

  test "creating a Space" do
    visit api_v1_front_spaces_url
    click_on "New Api/V1/Front/Space"

    click_on "Create Space"

    assert_text "Space was successfully created"
    click_on "Back"
  end

  test "updating a Space" do
    visit api_v1_front_spaces_url
    click_on "Edit", match: :first

    click_on "Update Space"

    assert_text "Space was successfully updated"
    click_on "Back"
  end

  test "destroying a Space" do
    visit api_v1_front_spaces_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Space was successfully destroyed"
  end
end
