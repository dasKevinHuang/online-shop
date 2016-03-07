require 'rails_helper'

describe "Admin", :js => true, :sauce => true do
  context "Admin Page Login" do
    before(:each) do
      visit root_path
      click_on("Admins Only")
    end
    it "should require login to access administration" do
      expect(page).to have_css('div.alert')
    end
    it "should show a login form for admin" do
      expect(page).to have_css('form')
    end
    it "should show a flash message when email & password is blank" do
      click_on("Log in")
      expect(page).to have_content("Invalid email or password.")
    end
    it "should not allow submission when email is invalid" do
      fill_in 'admin_email', with: 'blah'
      click_on("Log in")
      expect(current_path).to eq(admin_path)
    end
    it "should not allow login when email/password is incorrect" do
      fill_in 'admin_email', with: 'blah@blah.com'
      fill_in 'admin_password', with: 'blah'
      click_on("Log in")
      expect(page).to have_content("Invalid email or password.")
    end
    it "should show the admin panel when login is successful" do
      admin = FactoryGirl.create(:admin)
      admin.save!
      fill_in 'admin_email', with: admin.email
      fill_in 'admin_password', with: "timtim"
      click_on("Log in")
      expect(page).to have_content("Signed in successfully.")
    end
  end
  context "Administration Panel" do
    before(:each) do
      visit admin_path
      admin = FactoryGirl.create(:admin)
      admin.save!
      fill_in 'admin_email', with: admin.email
      fill_in 'admin_password', with: "timtim"
      click_on("Log in")
    end
    it "should have a new product button" do
      expect(page).to have_content("Add a New Product")
    end
  end
  context "New Product page" do
    before(:all) do
      visit admin_path
      admin = FactoryGirl.create(:admin)
      admin.save!
      fill_in 'admin_email', with: admin.email
      fill_in 'admin_password', with: "timtim"
      click_on("Log in")
    end
    before(:each) do
      visit new_product_path
    end
    it "displays new product form" do
      expect(page).to have_css('form.new_product')
    end
    context "New Product Form" do
      it "has a title field" do
        expect(page).to have_field("product[title]")
      end
      it "has a price field" do
        expect(page).to have_field("product[price]")
      end
      it "has a quantity field" do
        expect(page).to have_field("product[quantity]")
      end
      it "has a photo field" do
        expect(page).to have_field("product[photo]")
      end
      it "has a details field" do
        expect(page).to have_field("product[details]")
      end
    end
    context "Create a new product" do
      it "shows a flash message if title is missing" do
        click_on("Submit")
        expect(page).to have_content("Title can't be blank")
      end
      it "shows a flash message if quantity is missing" do
        click_on("Submit")
        expect(page).to have_content("Quantity can't be blank")
      end
      it "shows a flash message if quantity is not a number" do
        click_on("Submit")
        expect(page).to have_content("Quantity is not a number")
      end
      it "shows a flash message if details is missing" do
        click_on("Submit")
        expect(page).to have_content("Details can't be blank")
      end
      it "shows a flash message if photo is missing" do
        click_on("Submit")
        expect(page).to have_content("Photo can't be blank")
      end
      it "shows a flash message if url is invalid" do
        attach_file("product[photo]", Rails.root + "spec/fixtures/order.pdf")
        click_on("Submit")
        expect(page).to have_content("Photo content type is invalid")
      end
      it "shows the new product page when successful" do
        fill_in 'product[title]', with: "Test Title"
        fill_in 'product[price]', with: "55.55"
        fill_in 'product[quantity]', with: "5"
        attach_file("product[photo]", Rails.root + "spec/fixtures/test_nuts.jpg")
        fill_in 'product[details]', with: "This is the details part for our product"
        click_on("Submit")
        expect(page).to have_content("Test Title")
      end
    end

    it "has a categories field" do
      expect(page).to have_field("product[category_ids][]")
    end
  end
end
