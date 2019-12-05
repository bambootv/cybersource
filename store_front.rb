require 'sinatra'
require 'securerandom'
require './security'
require_relative 'config'

include ERB::Util

#set :erubis, :escape_html => true

get '/paymentbycard' do
	@access_key = Config::KEY['access_key']
	@profile_id = Config::KEY['profile_id']
  erb :'payment_by_card/signeddatafields'
end

post '/paymentbycard/unsigneddatafields' do
	if params['signed_date_time'].to_s.size == 0
		current_utc_xml_date_time = Time.now.utc.strftime "%Y-%m-%dT%H:%M:%S%z"
		current_utc_xml_date_time = current_utc_xml_date_time[0, current_utc_xml_date_time.length-5]
		current_utc_xml_date_time << 'Z'
		params.store 'signed_date_time', current_utc_xml_date_time
	end
	params.store 'signature', Security.generate_signature(params) if params['access_key'].to_s.size > 0
	erb :'payment_by_card/unsigneddatafields'
end

get '/paymentbytoken' do
	@access_key = Config::KEY['access_key']
	@profile_id = Config::KEY['profile_id']
  erb :'payment_by_token/signeddatafields'
end

post '/paymentbytoken/unsigneddatafields' do
	if params['signed_date_time'].to_s.size == 0
		current_utc_xml_date_time = Time.now.utc.strftime "%Y-%m-%dT%H:%M:%S%z"
		current_utc_xml_date_time = current_utc_xml_date_time[0, current_utc_xml_date_time.length-5]
		current_utc_xml_date_time << 'Z'
		params.store 'signed_date_time', current_utc_xml_date_time
	end
	params.store 'signature', Security.generate_signature(params) if params['access_key'].to_s.size > 0
  erb :'payment_by_token/unsigneddatafields'
end

post '/receipt' do
  @signature_valid = Security.valid? params
  erb :receipt
end

post '/backoffice' do
  puts "Backoffice POST notification received: #{params}"
end
