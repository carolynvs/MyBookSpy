class AmazonController < ApplicationController
  def search
    author = params[:author]
    if !author.to_s.empty?
      amazon = AmazonService.new(Rails.application.config.aws_tag, Rails.application.config.aws_key, Rails.application.config.aws_secret)
      @authors = amazon.search_for_author(author)
    end
  end
end
