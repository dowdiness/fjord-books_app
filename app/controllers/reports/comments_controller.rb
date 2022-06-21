# frozen_string_literal: true

class Reports::CommentsController < CommentsController
  def set_commentable
    super Report, 'report'
  end
end
