# frozen_string_literal: true

require 'test_helper'

class MicropostsInterface < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    log_in_as_in_integration(@user)
  end
end

class MicropostsInterfaceTest < MicropostsInterface
  test 'should paginate microposts' do
    get root_path
    assert_select 'div.pagination'
  end

  test 'should show errors but not creat micropost on invalid information' do
    assert_no_difference 'Micropost.count' do
      post microposts_path, params: {
        micropost: {
          content: ''
        }
      }
    end
    assert_select 'div#error_explanation'
    assert_select 'a[href=?]', '/?page=2'
  end

  test 'should create a micropost on valid submission' do
    content = 'ties the room'
    assert_difference 'Micropost.count', 1 do
      post microposts_path, params: {
        micropost: {
          content:
        }
      }
    end
    assert_redirected_to root_path
    follow_redirect!
    assert_match content, response.body
  end

  test 'should have micropost delete links on own profile page' do
    get users_path(@user)
    assert_select 'a', text: 'delete'
  end

  test 'should be able to delete own micropost' do
    first_micropost = @user.microposts.paginate(page: 1).first
    assert_difference 'Micropost.count', -1 do
      delete micropost_path(first_micropost)
    end
  end

  test "should not have delete links on other user's profile page" do
    get user_path(users(:archer))
    assert_select 'a', { text: 'delete', count: 0 }
  end
end

class MicropostSidebarTest < MicropostsInterface
  test 'should display the right micropost count' do
    get root_path
    assert_match "#{@user.microposts.count} microposts", response.body
  end
  test 'should user proper pluralization for zero microposts' do
    log_in_as_in_integration(users(:malory))
    get root_path
    assert_match '0 microposts', response.body
  end
  test 'should user proper pluralization for one microposts' do
    log_in_as_in_integration(users(:lana))
    get root_path
    assert_match '1 micropost', response.body
  end
end

# class ImageUploadTest < MicropostsInterface
#   test 'should have a file input field for images' do
#     get root_path
#     assert_select 'input[type=?]','file_field[image]'
#   end

#   test 'should be able to attach an image' do
#     cont = 'ties'
#     img = fixture_file_upload('kitten.jpg', 'image/jpeg')
#     post microposts_path,params:{
#       micropost:{
#         content:cont,
#         image: img
#       }
#     }
#     assert @user.micropost.image.attached?
#   end
# end
