# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy, as: :commentable

  cattr_accessor :current_user, instance_accessor: false

  def author?
    @@current_user.id == user_id
  end
end
