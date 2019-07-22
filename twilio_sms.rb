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
    @contact_list = settings['twilio']['contact_list']
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

  def send_in_batch(content)
    @contact_list.each do |number|
      send(number, content)
    end
  end

  def get_message(sms_sid)
    @client.messages(sms_sid).fetch
  end

  def persist_message(sms)
    RedshiftClient.new.create_record(sms.body, sms.date_created.to_date.to_s)
  end

  def delete_message(sms_sid)
    @client.messages(sms_sid).delete
  rescue
    # retry deleting after 3 seconds
    sleep 3
    @client.messages(sms_sid).delete
  end
end
