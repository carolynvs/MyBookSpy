class AmazonController < ApplicationController
  def search
    keyword = params[:keyword]
    if !keyword.to_s.empty?
      amazon = AmazonService.new(Rails.application.config.aws_tag, Rails.application.config.aws_key, Rails.application.config.aws_secret)
      @results = amazon.search(keyword)
    end
  end
end
