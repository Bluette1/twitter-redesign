require_relative './feeder'
module BookmarksHelper
  def author_username(bookmark)
    '@' << bookmark.thought.author.username
  end

  def author_full_name(bookmark)
    bookmark.thought.author.full_name
  end

  def thought_text(bookmark)
    bookmark.thought.text
  end

  def unbookmark_btn(bookmark)
    button_to '-/bookmark', user_bookmark_path(current_user.id,
                                                 bookmark.id), method: :delete, class: 'btn btn-primary', type: 'submit'
  end

  def trends
    Feeder.new.send_feed
  end
end
