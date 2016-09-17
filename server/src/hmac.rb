require 'digest'
require 'openssl'

class HMAC
  def self.digest(key, message)
    OpenSSL::HMAC.digest(OpenSSL::Digest::Digest.new('MD5'), key, message)
  end
end
