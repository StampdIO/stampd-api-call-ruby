# Requirements
# - Have Ruby installed
# - Install json. Run gem install json
# - Run ruby _apitest.rb

require 'net/http'
require 'rubygems'
require 'uri'
require 'json'

# Variables

client_id = ''
secret_key = ''
blockchain = 'DASH'
hash = ''

# Statics

api_url_base = 'https://stampd.io/api/v2.php' # using direct script access in Ruby
# api_url_base = 'http://dev.stampd.io/api/v2.php'

# Login to API service

uri = URI.parse(api_url_base)
args = {requestedURL: '/init', client_id: client_id, secret_key: secret_key}
uri.query = URI.encode_www_form(args)
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = api_url_base.match(/^https/)

login_request = Net::HTTP::Get.new(uri.request_uri)

login_response = http.request(login_request)
login_json = JSON.parse(login_response.body)
puts login_json
# login_json['message']
# login_json['type']
# login_json['code']
# login_json['session_id']

if login_json.key?('code') && login_json['code'] == 300
  puts 'Logged in successfully'
else
  puts 'Login failed, exiting'
  abort
end

# Post a hash

uri = URI.parse(api_url_base)
args = {requestedURL: '/hash',
        sess_id: login_json['session_id'],
        hash: hash,
        blockchain: blockchain,
        # meta_emails: '',
        # meta_notes: '',
        # meta_filename: '',
        # meta_category: '',
}
uri.query = URI.encode_www_form(args)
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = api_url_base.match(/^https/)

post_request = Net::HTTP::Post.new(uri.request_uri)

post_response = http.request(post_request)
post_json = JSON.parse(post_response.body)
puts post_json
# post_json['message']
# post_json['type']
# post_json['code']
# post_json['stamps_remaining']

# Get a hash

uri = URI.parse(api_url_base)
args = {requestedURL: '/hash',
        sess_id: login_json['session_id'],
        hash: hash,
        blockchain: blockchain
}
uri.query = URI.encode_www_form(args)
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = api_url_base.match(/^https/)

get_request = Net::HTTP::Get.new(uri.request_uri)

get_response = http.request(get_request)
get_json = JSON.parse(get_response.body)
puts get_json
# post_json['message']
# post_json['type']
# post_json['code']
# post_json['txid']