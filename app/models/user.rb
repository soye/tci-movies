class User < ApplicationRecord
  has_many :reviews

  before_save :downcase_email

  validates :email, presence: true, uniqueness: { case_sensitive: false }

  private

  def downcase_email
    self.email = email.try(:downcase)
  end
end