require "spec_helper"

describe BinEncode::Encoder do
  
  phrases = [
    "Hello, how are you?",
    "Very fine, thank you.",
    "It's all nice on ice, alright.",
    "When you light the path for someone else, you also light the path for yourself.",
    "LOUD NOISES"
  ]
  
  it "Encodes some text" do
    encoder = BinEncode::Encoder.new("ab")
    expect(encoder.encode("ab")).to eq "0 1"
  end

  it "Decodes some text" do
    encoder = BinEncode::Encoder.new("ab")
    expect(encoder.decode("0 1")).to eq "ab"
  end
  
  it "Encodes and then decodes text" do
    encoder = BinEncode::Encoder.new
    phrases.each do |phrase|
      msg = encoder.decode encoder.encode(phrase)
      expect(msg).to eq phrase
    end
  end
  
  it "Encodes in different bases" do
    phrase = ('a'..'z').to_a.join('')
    encoder = BinEncode::Encoder.new phrase
    2.upto(32) do |base|
      encoded = encoder.encode(phrase, base)
      decoded = encoder.decode(encoded, base)
      expect(decoded).to eq phrase
    end
  end

end
