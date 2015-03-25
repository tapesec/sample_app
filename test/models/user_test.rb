require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
  	@user = User.new(name: "lionnel", email: "lionel.dupouy@gmail.com", 
  		password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
  	assert @user.valid?
  end


  test "Name should be present" do
  	@user.name = "   "
  	assert_not @user.valid?
  end

  test "Email should be present" do
  	@user.email = " "
  	assert_not @user.valid?
  end

  test "name should not be too long max 50" do
  	@user.name = "a" * 51
  	assert_not @user.valid?
  end

  test "email should not be too long 245" do
  	@user.email = "a" * 246
  	assert_not @user.valid?
  end

  test "email validation should accept valid adress" do
  	email_adresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
  						 first.last@foo.jp alice+bob@baz.cn]
  	email_adresses.each	do | adress |
  		@user.email = adress
  		assert @user.valid?, "#{adress.inspect} should be valid"
  	end

  end

  test "email validation should reject invalid adress format" do
  	email_adresses = %w[user@example,com user_at_foo.org 
  						use.name@example.foo@bar_baz.com foo@bar+baz.com]
  	email_adresses.each do | adress |
  		@user.email = adress
  		assert_not @user.valid?, "#{adress.inspect} should be not invalid"
  	end

  end

  test "email should be save as lower case in database" do
  	email_down_case = "Lionel.DuPoUy@gmail.com"
  	@user.email = email_down_case
  	@user.save
  	assert_equal email_down_case.downcase, @user.reload.email
  end

  test "email adress should be unique" do
  	duplicate_user = @user.dup
  	duplicate_user.email = @user.email.upcase
  	@user.save
  	assert_not duplicate_user.valid?
  end

  test "password lenth must be minimum 6 characters long" do
  	@user.password = @user.password_confirmation = "a" * 5;
  	assert_not @user.valid?
  end

end