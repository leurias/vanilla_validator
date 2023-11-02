require "dry-validation"
require "vanilla_validator"
require 'benchmark/ips'

input = {
  "foo" => 'Hello dog',
  "bar" => 2,
  "baz" => "2023-01-00"
}

class NewUserContract < Dry::Validation::Contract
  params do
    required(:foo).value(:string)
    required(:bar).filled(:bool?)
    required(:email).filled(:string)
  end

  rule(:email) do
    unless /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.match?(value)
      key.failure('has invalid format')
    end
  end
end

n = 100
Benchmark.ips do |x|
  x.report('A') do
  	n.times do

  		contract = NewUserContract.new

			contract.(input).success?

  	end
  end
  x.report('B') do
  	n.times do

			result = VanillaValidator.validate(input, { 
				"foo" => "required", 
				"bar" => "required|boolean",
				"email" => "required|email",
        "date" => "required|after:2023-01-01"
			})
			result.valid

  	end
  end

  x.compare!
end