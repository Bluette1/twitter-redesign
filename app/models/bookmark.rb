class Bookmark < ApplicationRecord
  belongs_to :thought
  belongs_to :user

  validates :user, uniqueness: { scope: :thought}
end
