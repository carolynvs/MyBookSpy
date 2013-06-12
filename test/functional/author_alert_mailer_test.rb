require 'test_helper'

class AuthorAlertMailerTest < ActionMailer::TestCase
  test "book_published" do
    mail = AuthorAlertMailer.book_published
    assert_equal "Book published", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
