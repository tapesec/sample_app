require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test 'posted form must be invalid' do
  	get signup_path
  	
  	#comparison between the amount of users store in db before and after
  	# attempt to submit the signup form
  	assert_no_difference 'User.count' do
  		post users_path, user: { name: "",
  								 email: "toto@invalid",
  								 password: "foo",
  								 password_confirmation: "bar" }
	end
	assert_template 'users/new'
	assert_select 'div', 'The form containes 4 errors'

  end

  test "posted form must be valid" do
  	assert_difference 'User.count', 1 do
  		post_via_redirect users_path, user: {
  			name: "chatouille",
  			email: "chat@gmail.com",
  			password: "wolf1umip",
  			password_confirmation: "wolf1umip"
  		}
  	end
  	assert_template 'users/show'
  end

end
