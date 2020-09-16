class User < ApplicationRecord
  has_attached_file :photo, styles: { medium: '300x300>', thumb: '100x100>' }
  has_attached_file :cover_image, styles: { medium: '800x800>', thumb: '100x100>' }
  validates_attachment_content_type :photo, content_type: ['image/jpg', 'image/jpeg', 'image/png']
  validates :username, presence: true, length: { minimum: 2 }, uniqueness: true
  validates :full_name, presence: true, length: { minimum: 6 }

  has_many :followings_as_follower, class_name: 'Following', foreign_key: :follower_id, dependent: :destroy
  has_many :followed_users, through: :followings_as_follower, source: :followed, dependent: :destroy

  has_many :followings, foreign_key: :followed_id, dependent: :destroy
  has_many :followers, through: :followings, source: :follower, dependent: :destroy

  has_many :thoughts, foreign_key: :author_id, class_name: 'Thought', dependent: :destroy

  has_many :bookmarks, dependent: :destroy

  scope :ordered_by_most_recent, -> { order(created_at: :desc) }

  def not_followed
    User.ordered_by_most_recent.reject {|user| followed_users.include?(user) || user == self}
  end

  def not_bookmarked?(thought)
    bookmarks.include?(thought) ? true:false
  end

  def following?(user)
    return true if followed_users.include?(user) 
    false
  end

  def followed_users_and_own_thoughts
    p "here##################################", Thought.where(author: (followed_users + [self]))
    Thought.where(author: (followed_users + [self]))
  end
end
