require 'test_helper'

class UserFeedTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: 'example user', email: 'user@example.com',
                     password: 'foobar', password_confirmation: 'foobar')
  end

  test 'feed should have the right posts' do
    michael = users(:michael)
    archer = users(:archer)
    lana = users(:lana)

    lana.microposts.each do |post_following|
      assert michael.feed.include?(post_following)
      assert_equal michael.feed.distinct,michael.feed
    end
    michael.microposts.each do |self_following|
      assert michael.feed.include?(self_following)
    end
    archer.microposts.each do |post_un_followed|
      assert_not michael.feed.include?(post_un_followed)
    end
  end
end
