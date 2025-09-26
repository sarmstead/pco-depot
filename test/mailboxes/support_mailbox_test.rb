require "test_helper"

class SupportMailboxTest < ActionMailbox::TestCase
  test "SupportRequest created without an order when email has no orders" do
    customer_email = "hkeppert@example.net"
    receive_inbound_email_from_mail(
      to: "support@pcodepot.com",
      from: customer_email,
      subject: "Drill brokey. Please helpy!",
      body: "My drill broke. Can you help?!"
    )
    support_request = SupportRequest.last
    assert_equal customer_email, support_request.email
    assert_nil support_request.order
  end

  test "SupportRequest created with an order when email has orders" do
    customer_email = "jtaylor@example.net"
    recent_order = orders(:jill_most_recent)
    receive_inbound_email_from_mail(
      to: "support@pcodepot.com",
      from: customer_email,
      subject: "Other drill brokey. Please helpy!",
      body: "My other drill broke. Can you help?!"
    )
    support_request = SupportRequest.last
    assert_equal customer_email, support_request.email
    assert_equal recent_order, support_request.order
  end
end
