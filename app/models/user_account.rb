class UserAccount < ApplicationRecord
  after_initialize :set_balance_default
  belongs_to :user
  has_many :transactions

  validates :user_id, uniqueness: true

  private

  def set_balance_default
    self.balance = 0 if self.balance.nil?
  end
end