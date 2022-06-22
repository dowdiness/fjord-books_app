# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :user

  cattr_accessor :current_user, instance_accessor: false

  def author?(target_user)
    target_user.id == user_id
  end
end
