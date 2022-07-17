# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  setup do
    @user = create(:user, password: 'password')
    @report = create(:report)
  end

  test 'visiting the index' do
    sign_in @user
    visit reports_url
    assert_selector 'h1', text: '日報'
  end

  test 'login and create new report' do
    visit root_url

    fill_in 'Eメール', with: @user.email
    fill_in 'パスワード', with: 'password'
    click_on 'ログイン'

    assert_text 'ログインしました。'

    click_on '日報'
    click_on '新規作成'

    fill_in 'タイトル', with: '新しいタイトル'
    fill_in '内容', with: '新しい内容'
    click_on '登録する'

    assert_text '日報が作成されました。'
    assert_text '新しいタイトル'
    assert_text '新しい内容'
  end

  test 'edit report' do
    sign_in @user
    visit new_report_url

    fill_in 'タイトル', with: '新しいタイトル'
    fill_in '内容', with: '新しい内容'
    click_on '登録する'

    click_on '編集', match: :first, exact: true

    fill_in 'タイトル', with: '新しい更新タイトル'
    fill_in '内容', with: '新しい更新内容'
    click_on '更新する'

    assert_text '日報が更新されました。'
    assert_text '新しい更新タイトル'
    assert_text '新しい更新内容'
  end

  test 'delete report' do
    sign_in @user
    visit new_report_url

    fill_in 'タイトル', with: '新しいタイトル'
    fill_in '内容', with: '新しい内容'
    click_on '登録する'

    click_on '戻る'

    accept_alert do
      click_on '削除', match: :first, exact: true
    end

    assert_text '日報が削除されました。'
    assert_no_text '新しいタイトル'
  end

  test 'create comment' do
    sign_in @user
    visit reports_url
    click_on '詳細'

    fill_in 'comment_content', with: '新しいコメント'
    click_on 'コメントする'

    assert_text '新しいコメント'
  end
end
