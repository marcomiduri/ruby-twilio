require 'rubygems'
require './twilio_sms'
require 'sinatra'

# webhook params
# {
#   "ToCountry"=>"US",
#   "ToState"=>"TN",
#   "SmsMessageSid"=>"SM5451a4dc4583a5e631d5614ea5b91249",
#   "NumMedia"=>"0", "ToCity"=>"",
#   "FromZip"=>"20500",
#   "SmsSid"=>"SM5451a4dc4583a5e631d5614ea5b91249",
#   "FromState"=>"DC",
#   "SmsStatus"=>"received",
#   "FromCity"=>"WASHINGTON",
#   "Body"=>"dsadsadgdaa",
#   "FromCountry"=>"US",
#   "To"=>"+14234033511",
#   "MessagingServiceSid"=>"MG444e19c532db660efb576ab132c28691",
#   "ToZip"=>"",
#   "NumSegments"=>"1",
#   "MessageSid"=>"SM5451a4dc4583a5e631d5614ea5b91249",
#   "AccountSid"=>"AC9c1e41eeb8219b185de3488b2b9f428d",
#   "From"=>"+12029155873",
#   "ApiVersion"=>"2010-04-01"
# }
get '/' do
  "hello"
end

post "/new_message" do
  sms_service = TwilioSms.new
  sms = sms_service.get_message(params['SmsSid'])
  sms_service.persist_message(sms)
  sms_service.delete_message(params['SmsSid'])
  "saved message"
end
