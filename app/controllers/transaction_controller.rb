# frozen_string_literal: true

class TransactionController < ApplicationController
  def create
    with_org do
      KafkaService.producer_transaction transaction = transaction_params.to_json, @org_name
      rest_response transaction
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:name, :amount, :user_account_id, :transaction_type)
  end
end
