require_relative 'hmac.rb'
require 'pry'

LEAST_SIG_BITS_MASK = 0xF

class HOTP
  def initialize(key, counter)
    @key = key
    @counter = counter
  end

  def get
    hmac = HMAC.digest(@key, to_eight_byte_str(@counter.get))
    otp(hmac)
  end

  private

  def otp(hmac)
    truncated(hmac)
  end

  def truncated(hmac)
    offset = calculate_dynamic_offset(hmac)
    truncated_digest = four_bytes_from(offset, hmac)
    untrimmed_otp = human_readable(truncated_digest)
    trim(untrimmed_otp)
  end

  def trim(otp)
    "%06d" % limit_to_six_digits(otp)
  end

  def human_readable(digest)
    digest.pack('C*').unpack('I>').first & 0x7F_FF_FF_FF
  end

  def four_bytes_from(offset, hmac)
    hmac.bytes[offset..offset+3]
  end

  def calculate_dynamic_offset(hmac)
    hmac.bytes.last & LEAST_SIG_BITS_MASK
  end

  def to_eight_byte_str(count)
    [count].pack('Q>')
  end

  def limit_to_six_digits(otp)
    otp % 10**6
  end
end
