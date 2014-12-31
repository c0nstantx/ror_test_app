# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'spec_helper'

MAX_CHAR_USERNAME = 50
MAX_CHAR_EMAIL = 100
MIN_CHAR_PASSWORD = 6

describe User do

  before { @user = User.new(name: "Example User", email: "user@example.com", 
    password: "foobar", password_confirmation: "foobar") }

  subject { @user }

  it { should respond_to :name }
  it { should respond_to :email }
  it { should respond_to :password_digest }
  it { should respond_to :password }
  it { should respond_to :password_confirmation }
  it { should respond_to :authenticate }

  it { should be_valid }

  describe "when name is not present" do
    before { @user.name = "" }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @user.email = "" }
    it { should_not be_valid }
  end

  describe "when password is not present" do
    before { @user.password = @user.password_confirmation = "" }
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "when password confirmation is nil" do
    before { @user.password_confirmation = nil }
    it { should_not be_valid }
  end

  describe "when name is too long (#{MAX_CHAR_USERNAME} chars limit)" do
    before { @user.name = "a" * (MAX_CHAR_USERNAME + 1) }
    it { should_not be_valid }
  end

  describe "when email is too long (#{MAX_CHAR_EMAIL} chars limit)" do
    before { @user.email = "a" * (MAX_CHAR_EMAIL + 1) }
    it { should_not be_valid }
  end

  describe "when password is too short (#{MIN_CHAR_PASSWORD} chars minimum)" do
    before { @user.password = @user.password_confirmation = "a" * (MIN_CHAR_PASSWORD - 1) }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org 
        example.user@foo.foo@bar_baz.com foo@bar+baz.com]
      addresses.each { |invalid_address|
        @user.email = invalid_address
        @user.should_not be_valid
      }
    end
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each { |invalid_address|
        @user.email = invalid_address
        @user.should be_valid
      }
    end
  end

  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email.upcase!
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by_email(@user.email) }

    describe "with valid password" do
      it { should == found_user.authenticate(@user.password)}
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not == user_for_invalid_password }
      specify { user_for_invalid_password.should be_false }
    end
  end
end