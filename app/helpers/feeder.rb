require 'rss'
require 'open-uri'

class Feeder
  attr_reader :feeds

  def initialize()
    @feeds = []
    @urls = [
      'https://www.siliconrepublic.com/feed',
      'https://www.techmeme.com/feed.xml',
      'http://feeds.arstechnica.com/arstechnica/index/',
      'https://www.engadget.com/rss.xml',
      'https://www.technewsworld.com/perl/syndication/rssfull.pl',
      'https://techcrunch.com/feed/'
    ]
  end

  def send_feed
        check_news
  end

  private

  def check_news()
    @urls.each do |url|
      news = {}
      URI.parse(url).open do |rss|
        feed = RSS::Parser.parse(rss)
        channel = feed.channel.title
        feed.items.each do |item|
          title = item.title
          news[title.to_sym] = item.link
        end
     
          send_to_users(news, channel)
    
      end
    end

    @feeds
  end

  def send_to_users(news, channel)
    
    choice = rand(5)
    news_item = choose_news_item choice, news, channel
    send_rss news_item
   
  end

  def choose_news_item(choice, news, channel)
    news_item = {}
    index = 0
    news.each do |title, link|
      if choice == index
        news_item = {}
        news_item[:channel] = channel
        news_item[:title] = title
        news_item[:link] = link
        break
      end
      index += 1
    end
    news_item
  end

  def send_rss(news_item)
    channel = news_item[:channel]
    title = news_item[:title]
    link = news_item[:link]

    @feeds << news_item

  end
end
