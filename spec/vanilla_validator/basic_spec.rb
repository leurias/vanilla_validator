require 'spec_helper'

describe '#validate' do

	it 'validate required fields' do
		input = {
			"email" => 'john@gmail.com',
			"password" => '123456'
		}
		result = VanillaValidator.validate(input, {
			"email" => "required"
		})

		expect(result.validated).to eq({"email"=>"john@gmail.com"})
		expect(result.valid).to eq(true)
	end

	it 'validate required fields 2' do
		input = {
			"email" => nil,
			"password" => '123456'
		}
		result = VanillaValidator.validate(input, {
			"email" => "required"
		})

		expect(result.valid).to eq(false)
	end

	it 'validate boolean fields' do
		input = {
			"female" => true
		}
		result = VanillaValidator.validate(input, {
			"female" => "boolean"
		})

		expect(result.valid).to eq(true)
	end

	it 'validate boolean fields 2' do
		input = {
			"female" => '---'
		}
		result = VanillaValidator.validate(input, {
			"female" => "boolean"
		})

		expect(result.valid).to eq(false)
	end

	it 'validate falsy fields' do
		input = {
			"female" => 'no'
		}
		result = VanillaValidator.validate(input, {
			"female" => "falsy"
		})

		expect(result.valid).to eq(true)
	end

	it 'validate falsy fields 2' do
		input = {
			"female" => 'yes'
		}
		result = VanillaValidator.validate(input, {
			"female" => "falsy"
		})

		expect(result.valid).to eq(false)
	end

	it 'validate email fields' do
		input = {
			"email" => 'farid@divnotes.com'
		}
		result = VanillaValidator.validate(input, {
			"email" => "email"
		})

		expect(result.valid).to eq(true)
	end

	it 'validate email fields 2' do
		input = {
			"email" => 'sdcsdcsd.csdcsd'
		}
		result = VanillaValidator.validate(input, {
			"email" => "email"
		})

		expect(result.valid).to eq(false)
	end

	it 'validate max fields' do
		input = {
			"email" => 'farid@divnotes.com'
		}
		result = VanillaValidator.validate(input, {
			"email" => "email|max:32"
		})

		expect(result.valid).to eq(true)
	end

	it 'validate max fields 2' do
		input = {
			"email" => 'aa@bb.com'
		}
		result = VanillaValidator.validate(input, {
			"email" => "email|max:4"
		})

		expect(result.valid).to eq(false)
	end

	it 'validate min fields' do
		input = {
			"email" => 'farid@divnotes.com'
		}
		result = VanillaValidator.validate(input, {
			"email" => "email|min:8"
		})

		expect(result.valid).to eq(true)
	end

	it 'validate min fields 2' do
		input = {
			"email" => 'aa@bb.com'
		}
		result = VanillaValidator.validate(input, {
			"email" => "email|min:10"
		})

		expect(result.valid).to eq(false)
	end

	it 'validate like fields' do
		input = {
			"password" => "123456",
      "password_confirmation" => "123456"
		}
		result = VanillaValidator.validate(input, {
			"password" => "required",
      "password_confirmation" => "like:password"
		})

		expect(result.valid).to eq(true)
	end

	it 'validate like fields 2' do
		input = {
			"password" => "123456",
      "password_confirmation" => "1234567"
		}
		result = VanillaValidator.validate(input, {
			"password" => "required",
      "password_confirmation" => "like:password"
		})

		expect(result.valid).to eq(false)
	end

	it 'validate required_if fields' do
		input = {
			"foo" => 5,
			"bar" => 4,
		}
		result = VanillaValidator.validate(input, {
			"foo" => "required",
			"bar" => "required_if:foo,5",
		})

		expect(result.valid).to eq(true)
	end

end