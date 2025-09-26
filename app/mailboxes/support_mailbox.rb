class SupportMailbox < ApplicationMailbox
  def process
    email = mail.from_address.to_s
    recent_order = Order.where(email: email).order("created_at desc").first
    SupportRequest.create!(
      body: mail.body.to_s,
      email: email,
      subject: mail.subject,
      order: recent_order
    )
  end
end
