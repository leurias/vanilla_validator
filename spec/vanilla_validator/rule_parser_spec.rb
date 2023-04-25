require 'spec_helper'

describe VanillaValidator::RuleParser do
	it 'testcase 1' do
		rule = 'required|truthy'
		rules = described_class.parse(rule).map(&:name)
		expect(rules).to eq ["validate_required", "validate_truthy"]
	end

	it 'testcase 2' do
		rule = 'eq:4'
		rules = described_class.parse(rule).first
		expect(rules.name).to eq 'validate_eq'
		expect(rules.parameters).to eq ['4']
	end

	it 'testcase 3' do
		rule = 'between:4,10'
		rules = described_class.parse(rule).first
		expect(rules.name).to eq 'validate_between'
		expect(rules.parameters).to eq ['4', '10']
	end

	it 'testcase 4' do
		rule = 'in:4,5,6,7'
		rules = described_class.parse(rule).first
		expect(rules.name).to eq 'validate_in'
		expect(rules.parameters).to eq ['4', '5', '6', '7']
	end

	it 'testcase 5' do
		rule = 'required_if:quux,present'
		rules = described_class.parse(rule).first
		expect(rules.name).to eq 'validate_required_if'
		expect(rules.parameters).to eq ['quux', 'present']
	end

	it 'testcase 6' do
		rule = 'required_if:foo,in,true,false'
		rules = described_class.parse(rule).first
		expect(rules.name).to eq 'validate_required_if'
		expect(rules.parameters).to eq ['foo', 'in', 'true', 'false']
	end

	it 'testcase 7' do
		rule = 'required_if:bar,4'
		rules = described_class.parse(rule).first
		expect(rules.name).to eq 'validate_required_if'
		expect(rules.parameters).to eq ['bar', '4']
	end

	it 'testcase 8' do
		rule = proc { |attribute, value, fail| }
		rules = described_class.parse(rule).first
		expect(rules.name).to eq 'validate_proc'
		expect(rules.parameters).to be rule
	end

	it 'testcase 9' do
		class MyValidator < VanillaValidator::Rule
			def self.passes(attribute, value)
				
			end

			def self.message
				
			end
		end

		rule = MyValidator
		rules = described_class.parse(rule).first
		expect(rules.name).to eq 'validate_custom'
		expect(rules.parameters).to be rule
		pp rule.message
	end


end