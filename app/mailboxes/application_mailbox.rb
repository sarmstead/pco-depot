class ApplicationMailbox < ActionMailbox::Base
  # routing /something/i => :somewhere
  routing "support@pcodepot.com" => :support
end
