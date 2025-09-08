require "test_helper"

class OrderMailerTest < ActionMailer::TestCase
  test "received" do
    mail = OrderMailer.received(orders(:one))
    assert_includes mail.subject, orders(:one).name
    assert_equal [ orders(:one).email ], mail.to
    assert_equal [ "orders@pco.depot" ], mail.from
    assert_includes mail.body.encoded, orders(:one).line_items.first.product.title
  end

  test "shipped" do
    mail = OrderMailer.shipped(orders(:one))
    assert_includes mail.subject, "order is on its way"
    assert_equal [ orders(:one).email ], mail.to
    assert_equal [ "orders@pco.depot" ], mail.from
    assert_includes mail.body.encoded, orders(:one).line_items.first.product.title
  end
end
