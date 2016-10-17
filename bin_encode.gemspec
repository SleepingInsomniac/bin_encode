# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bin_encode/version'

Gem::Specification.new do |spec|
  spec.name          = "bin_encode"
  spec.version       = BinEncode::VERSION
  spec.authors       = ["Alex Clink"]
  spec.email         = ["alex@certedrive.com"]

  spec.summary       = "Encode text to binary format"
  spec.description   = "Encode text to binary by splitting the message space `n` times"
  spec.homepage      = "http://code.alexc.link/bin_encode"
  spec.license       = "MIT"

  spec.files = [
    "lib/**/*",
    "bin/**/*",
    "README.md"
  ].map {|g| Dir.glob(g)}.flatten

  spec.bindir        = "bin"
  spec.executables   = "bin_encode"
  spec.require_paths = ["lib"]
  
  spec.add_dependency "thor"

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
