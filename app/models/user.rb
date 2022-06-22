# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar
  has_many :active_follows, class_name: 'Follow', foreign_key: 'follower_id', inverse_of: 'follower', dependent: :destroy
  has_many :passive_follows, class_name: 'Follow', foreign_key: 'following_id', inverse_of: 'following', dependent: :destroy
  has_many :followings, through: :active_follows, source: :following
  has_many :followers, through: :passive_follows, source: :follower

  def follow(follow_user)
    active_follows.create(following_id: follow_user.id)
  end

  def unfollow(followed_user)
    unfollow_user = active_follows.find_by(following_id: followed_user.id)
    return if unfollow_user.blank?

    unfollow_user.destroy
  end

  def following?(other_user)
    followings.include?(other_user)
  end
end
