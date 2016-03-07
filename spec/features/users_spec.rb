require 'rails_helper'
require 'sidekiq/testing'
Sidekiq::Testing.fake! # fake is the default mode

describe "User", :js => true do
  context "Sign Up Page" do
    before(:each) do
      visit new_user_registration_path
    end
    it "should show the registration form" do
      expect(page).to have_css('form.new_user')
    end
    it "should not allow submission if invalid email" do
      fill_in 'user_email', with: 'invalidemail'
      find('input[type="submit"]').click
      expect(current_path).to eq(new_user_registration_path)
    end
    it "should show flash message when there is a password but no email" do
      fill_in 'user_password', with: 'password'
      find('input[type="submit"]').click
      expect(page).to have_content("Email can't be blank")
    end
    it "should show flash message when passwords do not match" do
      fill_in 'user_password', with: 'password'
      find('input[type="submit"]').click
      expect(page).to have_content("Password confirmation doesn't match Password")
    end
    it "should show flash message when email has already been taken" do
      fill_in 'user_email', with: 'tom@tom.com'
      find('input[type="submit"]').click
      expect(page).to have_content("Email has already been taken")
    end
    context "successful registration" do
      it 'should show flash message when successfully registered' do
        PostmanWorker.jobs.clear
        fill_in 'user_email', with: 'blah@blah.com'
        fill_in 'user_password', with: 'password'
        fill_in 'user_password_confirmation', with: 'password'
        find('input[type="submit"]').click
        expect(page).to have_content("Welcome! You have signed up successfully.")
      end
      it 'should have started a Sidekiq worker to send an email to the new user' do
        expect(PostmanWorker.jobs.size).to eq(1)
      end
    end
  end
    context "Sign in page" do
      before(:each) do
        visit new_user_session_path
      end
      it "should show the login form" do
        expect(page).to have_css('form.new_user')
      end
      it "should not allow submission if invalid email" do
        fill_in 'user_email', with: 'invalidemail'
        find('input[type="submit"]').click
        expect(current_path).to eq(new_user_session_path)
      end
      it "should show flash message when there is a password but no email" do
        fill_in 'user_password', with: 'password'
        find('input[type="submit"]').click
        expect(page).to have_css("div.alert")
      end
      it "should show flash message when an invalid email/password is submitted" do
        fill_in 'user_email', with:'blah@blah.com'
        fill_in 'user_password', with:'password'
        find('input[type="submit"]').click
        expect(page).to have_css("div.alert")
      end
      it "sign up link goes to registration page" do
        within('div.container') do
          click_on("Sign up")
          expect(current_path).to eq(new_user_registration_path)
        end
      end
      it "forgot password link goes to forgot password page" do
        click_on("Forgot your password?")
        expect(page).to have_content("Forgot your password?")
      end
      it "should login successfully with valid email/password" do
        fill_in 'user_email', with: "tom@tom.com"
        fill_in 'user_password', with: "tomtom" 
        find('input[type="submit"]').click
        expect(page).to have_css('div.alert', text: "Signed in successfully.")
        expect(current_path).to eq(root_path)
      end
    end
  end
