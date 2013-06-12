require 'date'
require 'vacuum'
require 'active_support'

class AmazonService
  def initialize(aws_tag, aws_key, aws_secret)

    #Rails.logger.info("Initializing AmazonService: \ntag: #{aws_tag} \nkey:#{aws_key} \nsecret:#{aws_secret}")

    @aws_tag = aws_tag
    @aws_key = aws_key
    @aws_secret = aws_secret
  end

  def search_for_books_by(author, min_pubdate = nil)
    author = author.downcase

    #Rails.logger.info("Searching Amazon for the author: #{author}")
    request = Vacuum.new

    request.configure(tag: @aws_tag, key: @aws_key, secret: @aws_secret)

    power_search = "author: \"#{author}\""
    power_search += " and pubdate: after #{min_pubdate.strftime('%m-%Y')}" if !min_pubdate.nil?

    # http://docs.aws.amazon.com/AWSECommerceService/latest/DG/PowerSearchSyntax.html
    params = {
      'Operation' => 'ItemSearch',
      'SearchIndex' => 'Books',
      'Power' => power_search
    }

    response = request.get(query: params)
    puts response.body
    books = parse_search_result(response.body)

    # exclude books which don't appear to be authored by the queried author
    books = books.select { |book| !book.authors.nil? && book.authors.any? { |a| a.downcase.include?(author)}}
    return books
  end

  def search_for_author(author)
    author = author.downcase
    books = search_for_books_by(author)

    if(books.nil?)
      return nil
    end

    authors = AmazonAuthor.from_books(books)
    return authors.select { |x| x.name.downcase.include?(author) }
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
  attr_reader :title, :authors, :asin, :url, :add_to_wishlist_url

  def initialize(item)
    @title = item['ItemAttributes']['Title']
    @authors = item['ItemAttributes']['Author'] || []

    if @authors.is_a?(String)
       @authors = [@authors]
    end

    contributors = item['ItemAttributes']['Creator']
    if contributors.is_a?(String)
      @authors << contributors
    elsif !contributors.nil?
      @authors.concat(contributors)
    end

    @asin = item['ASIN']
    @url = item['DetailPageURL']
    wishlist_link = item['ItemLinks']['ItemLink'].find { |link| link['Description'].include?('Wishlist') }
    @add_to_wishlist_url = wishlist_link['URL']
  end
end

class AmazonAuthor
  attr_reader :name, :books

  def initialize(name)
    @name = name
    @books = []
  end

  def self.from_books(books)
    authors = {}

    books.each do |book|
      book.authors.each do |author|
        if authors[author].nil?
          authors[author] = AmazonAuthor.new(author)
        end
        authors[author].books << book
      end
    end

    return authors.values
  end
end