require 'active_support/core_ext'
require_relative 'amazon_service'
require_relative 'author'
require_relative 'author_alert'
require_relative 'author_alert_history'
require_relative 'book'


class AlertService
  def self.execute
    alert_service = AlertService.new(Rails.application.config.aws_tag, Rails.application.config.aws_key,
                                     Rails.application.config.aws_secret)

    alert_service.process_author_alerts
  end

  def initialize(aws_tag, aws_key, aws_secret)
    @amazon = AmazonService.new(aws_tag, aws_key, aws_secret)
  end

  def process_author_alerts
    last_week = Date.today.advance(weeks: -1)
    authors = Author.joins(:author_alerts).where('authors.last_sync_date < ?', last_week).limit(10)

    authors.each do |author|
      new_books = @amazon.search_for_books_by(author.name, author.last_sync_date)

      new_books.each do |new_book|
        book = Book.create(author_id: author.id, title: new_book.title, url: new_book.url)

        author.author_alerts.each do |alert|
          AuthorAlertHistory.create(author_alert_id: alert.id, book_id: book.id)
        end
      end
    end
  end
end