# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  setup do
    @report = create(:report)
  end

  test 'report should be valid' do
    assert @report.valid?
  end

  test 'title should not be blank' do
    @report.title = ''
    assert_not @report.valid?
  end

  test 'content should not be blank' do
    @report.content = ''
    assert_not @report.valid?
  end

  test 'editable?' do
    target_user = @report.user
    other_user = create(:user)
    assert @report.editable?(target_user)
    assert_not @report.editable?(other_user)
  end

  test 'created_on' do
    assert_equal @report.created_on, @report.created_at.to_date
  end
end
