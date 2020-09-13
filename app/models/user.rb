class User < ApplicationRecord
  has_attached_file :photo, styles: { medium: '300x300>', thumb: '100x100>' }
  has_attached_file :cover_image, styles: { medium: '300x300>', thumb: '100x100>' }
  validates_attachment_content_type :photo, content_type: ['image/jpg', 'image/jpeg', 'image/png']
  validates :username, presence: true, length: { minimum: 2 }, uniqueness: true
  validates :full_name, presence: true, length: { minimum: 6 }

  has_many :followings_as_follower, class_name: 'Following', foreign_key: :follower_id, dependent: :destroy
  has_many :followed, through: :followings_as_follower, source: :followed, dependent: :destroy

  has_many :followings, foreign_key: :followed_id, dependent: :destroy
  has_many :followers, through: :followings, source: :follower, dependent: :destroy

  has_many :thoughts, class_name: 'Thought', foreign_key: :author_id, dependent: :destroy

  has_many :bookmarks, dependent: :destroy
end
