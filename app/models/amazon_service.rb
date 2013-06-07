class AmazonService
  def initialize(aws_tag, aws_key, aws_secret)

    Rails.logger.info("Initializing AmazonService: \ntag: #{aws_tag} \nkey:#{aws_key} \nsecret:#{aws_secret}")

    @aws_tag = aws_tag
    @aws_key = aws_key
    @aws_secret = aws_secret
  end

  def search(keyword)
    Rails.logger.info("Searching Amazon for: #{keyword}")
    request = Vacuum.new

    request.configure(tag: @aws_tag, key: @aws_key, secret: @aws_secret)

    params = {
      'Operation' => 'ItemSearch',
      'SearchIndex' => 'Books',
      'Keywords' => keyword
    }

    response = request.get(query: params)
    parse_search_result(response.body)
  end

  private
  def parse_search_result(xml)
    hash = Hash.from_xml(xml)

    items = hash['ItemSearchResponse']['Items']['Item']
    if items.nil?
      return nil
    end

    items.map do |item|
      AmazonBook.new(item)
    end
  end
end

class AmazonBook
  attr_reader :title, :author, :asin, :url, :add_to_wishlist_url

  def initialize(item)
    @title = item['ItemAttributes']['Title']
    @author = item['ItemAttributes']['Author']

    @asin = item['ASIN']
    @url = item['DetailPageURL']
    wishlist_link = item['ItemLinks']['ItemLink'].find { |link| link['Description'].include?('Wishlist') }
    @add_to_wishlist_url = wishlist_link['URL']
  end
end