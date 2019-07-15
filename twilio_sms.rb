require 'rubygems'
require 'twilio-ruby'
require './settings'
require './redshift_client'

class TwilioSms
	def initialize
		settings = Settings.load
		@account_sid = settings['twilio']['sid']
		@auth_token = settings['twilio']['secret']
		@client = Twilio::REST::Client.new(@account_sid, @auth_token)
    @sms_service_sid = settings['twilio']['sms_service_sid']
  end

  def client
    @client
  end

	def send(to, content)
		@client.messages.create(
			body: content,
      messaging_service_sid: @sms_service_sid,
			to: to
		)
  end

  def get_message(sms_sid)
    @client.messages(sms_sid).fetch
  end

  def persist_message(sms)
    RedshiftClient.new.create_record(sms.from, sms.to, sms.body, sms.date_created.to_date.to_s)
  end

  def delete_message(sms_sid)
    @client.messages(sms_sid).delete
  rescue
    sleep 3
    delete_message(sms_sid)
  end

	def receive(message_content)

	end
end
