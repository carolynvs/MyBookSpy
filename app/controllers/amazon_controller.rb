class AmazonController < ApplicationController
  def search
    author = params[:author]
    if !author.to_s.empty?
      amazon = AmazonService.new(Rails.application.config.aws_tag, Rails.application.config.aws_key, Rails.application.config.aws_secret)
      @results = amazon.search_for_books_by(author)
    end
  end
end
