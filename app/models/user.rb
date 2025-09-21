class User < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email_address, presence: true, uniqueness: true

  has_secure_password

  has_many :sessions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  after_destroy :ensure_admin_remains

  class Error < StandardError
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  private

  def ensure_admin_remains
    if User.count.zero?
      raise Error.new "Yikes! You can't delete the last user, silly billy."
    end
  end
end
