require "spec_helper"

def parse_opts(options)
  options = options.to_a.map do |opt|
    o,v = opt
    o = o.to_s.gsub /[^a-z]/i, '-'
    opt = [o,v].join "="
    prefix = o.length > 1 ? "--" : "-"
    "#{prefix}#{opt}"
  end
  options.join " "
end


def bin_encode(phrase, options = {})
  options = parse_opts(options)
  `./bin/bin_encode "#{phrase}" #{options}`
end

def decode(phrase)
  `./bin/bin_encode -d "#{phrase}"`
end

describe "BinEncode::Cli" do

  it "Encodes and then decodes text" do
    phrases = [
      "Hello, how are you?",
      "Very fine, thank you.",
      "It's all nice on ice, alright.",
      "When you light the path for someone else, you also light the path for yourself.",
      "LOUD NOISES"
    ]
    phrases.each do |phrase|
      encoded = bin_encode phrase
      decoded = bin_encode encoded, decode: true
      expect(decoded).to eq phrase
    end
  end
  
  it "Encodes from a file" do
    file_path = File.expand_path __FILE__
    encoded = bin_encode file_path, file: true
    decoded = bin_encode encoded, decode: true
    expect(decoded).to eq File.read(File.expand_path(__FILE__))
  end

end
