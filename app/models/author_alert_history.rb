require 'active_record'

class AuthorAlertHistory < ActiveRecord::Base
  attr_accessible :author_alert_id, :book_id

  belongs_to :author_alert
  belongs_to :book
end
