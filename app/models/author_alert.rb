require 'active_record'

class AuthorAlert < ActiveRecord::Base
  attr_accessible :author_id, :user_id

  belongs_to :author
  belongs_to :user
  has_many :author_alert_histories
end