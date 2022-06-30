# frozen_string_literal: true

require 'application_system_test_case'

class RelationshipsTest < ApplicationSystemTestCase
  setup do
    @user = create(:user)
    @other_user = create(:user)
    sign_in @user
  end

  test 'creat and delete a relationship' do
    visit "users/#{@other_user.id}"
    click_on 'フォローする'

    assert_text 'フォローしました。'
    click_on 'フォロー解除する'

    assert_text 'フォロー解除しました。'
  end
end
