require "application_system_test_case"

class BusinessesTest < ApplicationSystemTestCase
  setup do
    @business = businesses(:one)
  end

  test "visiting the index" do
    visit businesses_url
    assert_selector "h1", text: "Businesses"
  end

  test "should create business" do
    visit businesses_url
    click_on "New business"

    fill_in "Industry", with: @business.industry_id
    fill_in "Name", with: @business.name
    fill_in "Num of employees", with: @business.num_of_employees
    fill_in "Products", with: @business.products
    fill_in "User", with: @business.user_id
    click_on "Create Business"

    assert_text "Business was successfully created"
    click_on "Back"
  end

  test "should update Business" do
    visit business_url(@business)
    click_on "Edit this business", match: :first

    fill_in "Industry", with: @business.industry_id
    fill_in "Name", with: @business.name
    fill_in "Num of employees", with: @business.num_of_employees
    fill_in "Products", with: @business.products
    fill_in "User", with: @business.user_id
    click_on "Update Business"

    assert_text "Business was successfully updated"
    click_on "Back"
  end

  test "should destroy Business" do
    visit business_url(@business)
    click_on "Destroy this business", match: :first

    assert_text "Business was successfully destroyed"
  end
end
