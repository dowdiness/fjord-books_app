# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = create(:user)
    @other_user = create(:user)
  end

  test 'name_or_email with name' do
    assert @user.name_or_email, @user.name
  end

  test 'name_or_email without name' do
    noname_user = create(:user, name: nil)
    assert_equal(noname_user.name_or_email, noname_user.email)
  end

  test 'folllowing? and followed_by?' do
    @user.active_relationships.find_or_create_by!(following_id: @other_user.id)
    assert(@user.following?(@other_user))
    assert(@other_user.followed_by?(@user))
  end

  test 'follow and unfollow' do
    @user.follow @other_user
    assert @user.following?(@other_user)
    @user.unfollow @other_user
    assert_not @user.following?(@other_user)
  end
end
