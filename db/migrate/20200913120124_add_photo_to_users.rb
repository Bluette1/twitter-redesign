class AddPhotoToUsers < ActiveRecord::Migration[6.0]
  def self.up
    add_attachment :users, :photo
  end

  def self.down
    remove_attachment :users, :photo
  end
end
