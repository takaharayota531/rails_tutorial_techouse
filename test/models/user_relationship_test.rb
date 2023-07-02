# frozen_string_literal: true

require 'test_helper'

class UserRelationshipTest < ActiveSupport::TestCase
  test 'should follow and unfollow a user' do
    michael = users(:michael)
    archer = users(:archer)

    assert_not michael.following?(archer)
    michael.follow(archer)
    assert michael.following?(archer)
    assert archer.followers.include?(michael)

    michael.unfollow(archer)
    assert_not michael.following?(archer)

    michael.follow(michael)
    assert_not michael.following?(michael)
  end
end
