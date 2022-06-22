# frozen_string_literal: true

class Follow < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :following, class_name: 'User'
  # 自分へのフォローは出来ない
  validates :follower_id, presence: true
  validates :following_id, presence: true
  validate :cannot_follow_myself

  def cannot_follow_myself
    return if follower_id != following_id

    errors.add :base, :invalid, message: '自分へのフォローは出来ません'
  end
end
