require 'active_record'

class Book < ActiveRecord::Base
  attr_accessible :author_id, :publish_date, :title, :url

  belongs_to :author
end
