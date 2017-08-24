require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(email: "user@example.com")
  end

  test "user should be valid" do
    assert @user.valid?
  end

  test "email should be present" do
    @user.email = ""
    assert_not @user.save, "saved user without email"
  end

  test "email regex validation" do
    valid_emails = ["user@example.com", "A+345_0@gmail.com", "first.last@yahoo.co.jp", "jokes@foo.org"]
    valid_emails.each do |email|
      @user.email = email
      assert @user.valid?, "#{email} should be valid"
    end

    invalid_emails = ["first@last", "name@gmail,com", "first_at_last.com", "name@example.", "$#jokes.com"]
    invalid_emails.each do |email|
      @user.email = email
      assert_not @user.valid?, "#{email} should not be valid"
    end
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.save, "saved user with duplicate email"
  end

  test "email address should be downcased when saved" do
    mixed_case_email = "ahHHHHH@dead.COM"
    @user.email = mixed_case_email
    @user.save
    assert_equal @user.reload.email, mixed_case_email.downcase
  end
end