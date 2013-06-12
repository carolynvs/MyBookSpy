class AuthorAlertMailer < ActionMailer::Base
  default from: 'notify@mybookspy.com'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.author_alert_mailer.book_published.subject
  #
  def book_published(author_alert, book)
    @book = book
    @author = author_alert.author.name

    mail to: author_alert.user.email, subject: "#{@author} has published a new book"
  end
end
