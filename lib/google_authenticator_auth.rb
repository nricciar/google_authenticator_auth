#!/usr/bin/env ruby
# A simple class to work with Google Authenticator from ruby
#
# can generate a secret key along with qrcode url/image and authenticate
# keys against a secret key
#
# See Also: http://code.google.com/p/google-authenticator/
#
require 'rubygems'
require 'base32'
require 'openssl'
require 'uri'
require 'SecureRandom'

class GoogleAuthenticator

  # Load class with the provided secret key.  If no key is
  # provided generate a new random secret key
  def initialize(key=nil)
    @secret_key = key.nil? ? GoogleAuthenticator.generate_secret_key : key
  end

  # Generate a unique secret key
  def self.generate_secret_key
    Base32.encode( (0...10).map{(SecureRandom.random_number(255)).chr}.join )
  end

  # Google Charts image URL (resulting image can be scanned by
  # the Google Authenticator app to automaticly import secret key
  def qrcode_image_url(label,wh=350)
    "https://chart.googleapis.com/chart?chs=#{wh}x#{wh}&cht=qr&choe=UTF-8&chl=" + uri_parser.escape(qrcode_url(label))
  end

  # QRCode URL used to generate a QRCode that can be scanned into
  # Google Authenticator (see qrcode_image_url)
  def qrcode_url(label)
    "otpauth://totp/#{label}?secret=#{@secret_key}"
  end

  # Current secret key
  def secret_key
    @secret_key
  end

  # Checks to see if the key is valid for the current secret key
  def key_valid?(key)
    get_keys.include?(key.to_i)
  end

  # Found at https://gist.github.com/987839
  # Returns an array containing the previous, current, and next
  # valid key for the current secret key
  def get_keys
    keys = []
    int = 30
    now = Time.now.to_i / int
    key = Base32.decode @secret_key
    sha = OpenSSL::Digest::Digest.new('sha1')

    (-1..1).each do |x|
      bytes = [ now + x ].pack('>q').reverse
      hmac = OpenSSL::HMAC.digest(sha, key.to_s, bytes)
      offset = nil
      if RUBY_VERSION > '1.9'
        offset = hmac[-1].ord & 0x0F
      else
        offset = hmac[-1] & 0x0F
      end
      hash = hmac[offset...offset + 4]

      code = hash.reverse.unpack('L')[0]
      code &= 0x7FFFFFFF
      code %= 1000000

      keys << code
    end

    keys
  end

  protected
  def uri_parser
    @uri_parser ||= URI.const_defined?(:Parser) ? URI::Parser.new : URI
  end

end
