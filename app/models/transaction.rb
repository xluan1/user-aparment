class Transaction < ApplicationRecord
  before_create :check_balance
  after_create :submit_balance
  belongs_to :user_account
  enum transaction_type: %w[deposit withdraw]

  validates :transaction_type, :name, :user_account_id, presence: true
  validates :amount, numericality: { greater_than: 0 }

  private

  def submit_balance
    @account.with_lock do
      case transaction_type
      when "deposit"
        @account.balance += amount
      when "withdraw"
        @account.balance -= amount
      else
        # type code here
      end
      @account.save!
    end
  end

  def check_balance
    @account = UserAccount.find_by_id(user_account_id)
    if transaction_type === "withdraw"
      raise "Not found or balance less than #{amount}, userAccountId: #{user_account_id}" unless (@account) && @account.balance >= amount
    end
  end
end
