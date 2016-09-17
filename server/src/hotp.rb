require 'openssl'
require_relative './hmac.rb'

class HOTP
  def initialize(key, counter)
    @key = key
    @counter = counter
  end

  def get
    hmac = bin_to_hex(HMAC.digest(@key, @counter.get))
    "%06d" % dynamic_truncate(hmac)
  end

  private

  def dynamic_truncate(digest)
    bytes = digest.scan(/../)
    offset = dynamic_offset(bytes)
    truncated_digest = four_bytes_of_digest_from(offset, digest)
    human_readable(truncated_digest)
  end

  def dynamic_offset(bytes)
    (offset = bytes.last.split("").last.to_i(16)) > 12 ? 12 : offset
  end

  def human_readable(digest)
    binary = digest.to_i(16).to_s(2)
    binary = binary[1..-1]
    number = binary.to_i(2) % 10**6
  end

  def four_bytes_of_digest_from(offset, digest)
    digest[offset..offset+7]
  end

  def bin_to_hex(binary_string)
    binary_string.each_byte.map { |b| b.to_s(16) }.join
  end
end
