module BinEncode
  
  DEFAULT_MESSAGE_SPACE = <<-SPACE
    abcdefghijklmnopqrstuvwxyz
    ABCDEFGHIJKLMNOPQRSTUVWXYZ
    0123456789
    .,/=+-_`\\'<>":!?@#$%^&*(){}[]|
  SPACE
  
  class Encoder
    def initialize(message_space = DEFAULT_MESSAGE_SPACE)
      @message_space = message_space.chars.uniq.join
      @entropy = Math.log2(message_space.length).ceil
    end
    
    attr_reader :entropy
    attr_reader :message_space
    
    def encode(message, base = 2)
      encoded = message.each_char.map {|c| encode_char(c, base) }.join(" ")
    end
    
    def decode(message, base = 2)
      decoded = message.split(/\s+/).map {|c| decode_char(c, base) }.join
    end
    
    private
    
    def left_of(string)
      string[0...(string.length/2)]
    end
    
    def right_of(string)
      string[(string.length/2)..-1]
    end
    
    def encode_char(char, base = 2)
      search_space = @message_space
      bin_string = ""
      while search_space.length > 1
        l = search_space.length / 2
        left, right = left_of(search_space), right_of(search_space)
        if left.include? char
          bin_string = "0" << bin_string
          search_space = left
        else
          bin_string = "1" << bin_string
          search_space = right
        end
      end
      bin_string.to_i(2).to_s(base)
    end
    
    def decode_char(char, base = 2)
      search_space = @message_space
      bin_string = char.to_i(base).to_s(2).reverse
      bin_string.each_char do |d|
        break if search_space.length == 1
        l = search_space.length / 2
        if d == "0"
          search_space = left_of(search_space)
        else
          search_space = right_of(search_space)
        end
      end
      search_space[0]
    end
    
  end
end