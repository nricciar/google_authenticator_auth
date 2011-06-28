# encoding: utf-8
require File.expand_path(File.join(File.dirname(__FILE__),'test_helper'))

class GoogleAuthenticatorAuthTest < ActiveSupport::TestCase

  test "should create a random key when started with no paramaters" do
    ga = GoogleAuthenticator.new
    assert_not_nil ga.secret_key
  end
 
  test "should return three keys" do
    ga = GoogleAuthenticator.new
    assert_equal ga.get_keys.length, 3
  end 

  test "should return a valid qrcode url" do
    ga = GoogleAuthenticator.new('NINWS2QUIQD2LA2Z')
    assert_equal ga.qrcode_image_url("user@domain.com"), "https://chart.googleapis.com/chart?chs=350x350&cht=qr&choe=UTF-8&chl=otpauth://totp/user@domain.com?secret=NINWS2QUIQD2LA2Z"
    assert_equal ga.qrcode_url("user@domain.com"), "otpauth://totp/user@domain.com?secret=NINWS2QUIQD2LA2Z"
  end

  test "returned keys should be valid" do
    ga = GoogleAuthenticator.new
    ga.get_keys.each do |key|
      assert ga.key_valid?(key)
    end
  end

end
