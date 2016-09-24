require_relative 'hmac.rb'

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
    "%06d" % (otp % 10**6)
  end

  def human_readable(digest)
    digest.map { |byte| "%08b" % byte }.join.split("").last(31).join.to_i(2)
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
end
