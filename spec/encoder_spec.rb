require "spec_helper"

describe BinEncode::Encoder do
  
  it "Exists" do
    expect(BinEncode::Encoder).not_to be nil
  end

  it "Encodes some text" do
    encoder = BinEncode::Encoder.new("ab")
    expect(encoder.encode("ab")).to eq "01"
  end

  it "Decodes some text" do
    encoder = BinEncode::Encoder.new("ab")
    expect(encoder.decode("01")).to eq "ab"
  end
  
  it "Encodes and then decodes text" do
    encoder = BinEncode::Encoder.new
    phrases = [
      "Hello, how are you?",
      "Very fine, thank you.",
      "It's all nice on ice, alright.",
      "When you light the path for someone else, you also light the path for yourself.",
      "LOUD NOISES"
    ]
    phrases.each do |phrase|
      msg = encoder.decode encoder.encode(phrase)
      expect(msg).to eq phrase
    end
  end

end
