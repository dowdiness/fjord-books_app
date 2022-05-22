# frozen_string_literal: true

class FollowValidator < ActiveModel::Validator
  def validate(record)
    return unless record.follower_id == record.following_id

    record.errors.add :base, :invalid, message: '自分へのフォローは出来ません'
  end
end

class Follow < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :following, class_name: 'User'
  # 自分へのフォローは出来ない
  validates :follower_id, presence: true
  validates :following_id, presence: true
  validates_with FollowValidator
end
