# frozen_string_literal: true

class Books::CommentsController < CommentsController
  def set_commentable
    super Book, 'book'
  end
end
