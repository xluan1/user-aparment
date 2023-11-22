# frozen_string_literal: true

class KafkaService
  def self.init_broker
    @kafka = Kafka.new "localhost:9092" unless @kafka
  end

  def self.consumer_transaction(topic, group_id)
    init_broker
    consumer = @kafka.consumer group_id: group_id
    consumer.subscribe topic
    consumer.each_message do |message|
      OrganizationService.with_org(topic) do
        begin
          event = JSON.parse(message.value)
          Transaction.create!(:name => event["name"], :transaction_type => event["transaction_type"], :amount => event["amount"], :user_account_id => event["user_account_id"])
          puts event
        rescue Exception => e
          puts "Create transaction failed!, topic:#{topic} at offset:#{message.offset}"
          puts "Error message: #{e.message}"
        end
      end
    end
  end

  def self.producer_transaction(message, topic = "public")
    init_broker
    @kafka.deliver_message message, topic: topic
  end
end
