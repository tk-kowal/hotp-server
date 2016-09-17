require 'rspec'
require_relative '../src/hmac.rb'

describe HMAC do
  let(:key)      { "Jefe" }
  let(:msg)      { "what do ya want for nothing?" }
  let(:expected) { "750c783e6ab0b503eaa86e310a5db738" }
  it 'generates an HMAC from a key and message' do
    expect(HMAC.digest(key, msg)).to eq [expected].pack("H*")
  end
end
