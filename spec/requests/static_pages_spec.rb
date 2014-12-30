require 'spec_helper'

describe "Static pages" do
  let(:title) { "Ruby on Rails Tutorial Sample App | #{$subtitle}" }

  describe "Home page" do
    it "should have the h1 'my First RoR App'" do
      visit root_path
      page.should have_selector('h1', :text => 'my First RoR App')
    end

    it "should have the right title" do
      visit root_path
      page.should have_selector('title',
        :text => "Ruby on Rails Tutorial Sample App")
    end

    it "should not have a custom page title" do
      $subtitle = "Home"
      visit root_path
      page.should_not have_selector('title',
        :text => $subtitle)
    end
  end

  describe "Help page" do
    it "should have the h1 'Help'" do
      visit help_path
      page.should have_selector('h1', :text => 'Help')
    end

    it "should have the right title" do
      $subtitle = "Help"
      visit help_path
      page.should have_selector('title',
        :text => title)
    end
  end

  describe "About page" do
    it "should have the h1 'About Us'" do
      visit about_path
      page.should have_selector('h1', :text => 'About Us')
    end

    it "should have the right title" do
      $subtitle = "About Us"
      visit about_path
      page.should have_selector('title',
        :text => title)
    end
  end

  describe "Contact page" do
    it "should have the h1 'Contact'" do
      visit contact_path
      page.should have_selector('h1', :text => 'Contact')
    end

    it "should have the right title" do
      $subtitle = "Contact"
      visit contact_path
      page.should have_selector('title',
        :text => title)
    end
  end
end
