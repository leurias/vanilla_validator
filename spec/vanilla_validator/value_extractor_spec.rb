require 'spec_helper'

describe VanillaValidator::ValueExtractor do

	it 'testcase 1' do
		data   = { "foo" => "bar" }
		path   = "foo"
		result = "bar"
		expect(described_class.get(data, path)).to eql result
	end

	it 'testcase 2' do
		data   = { "foo" => { "bar" => "baz" } }
		path   = "foo.bar"
		result = "baz"
		expect(described_class.get(data, path)).to eql result
	end

	it 'testcase 3' do
		data   = { "foo" => { "bar" => [ { "baz" => "qux" }, { "baz" => "quux" } ] } }
		path   = "foo.bar.1.baz"
		result = "quux"
		expect(described_class.get(data, path)).to eql result
	end

	it 'testcase 4' do
		data   = [ { "foo" => "bar" }, { "foo" => "baz" } ]
		path   = "*"
		result = data
		expect(described_class.get(data, path)).to eql result
	end

	it 'testcase 5' do
		data   = [ [ { "foo" => "bar" } ], [ { "foo" => "baz" } ] ]
		path   = "*.*"
		result = [ { "foo" => "bar" }, { "foo" => "baz" } ]
		expect(described_class.get(data, path)).to eql result
	end

	it 'testcase 6' do
		data   = [ [ [1,2], [3,4], "x" ], [ [5,6], [7,8], "y" ], [ [9,10], [11,12], "z" ] ]
		path   = "*.*.*"
		result = [1,2,3,4,nil,5,6,7,8,nil,9,10,11,12,nil]
		expect(described_class.get(data, path)).to eql result
	end

	it 'testcase 7' do
		data   = { "foo" => [ [1,2], [3,4], [5,6] ] }
		path   = "foo.*.*"
		result = [1,2,3,4,5,6]
		expect(described_class.get(data, path)).to eql result
	end

	it 'testcase 8' do
		data   = { "foo" => [ { "bar" => "quux 1" }, { "bar" => "quux 2" } ] }
		path   = "foo.*.bar"
		result = ["quux 1", "quux 2"]
		expect(described_class.get(data, path)).to eql result
	end

	it 'testcase 9' do
		data   = { "foo" => [ { "bar" => "quux 1" }, { "bar" => "quux 2" } ] }
		path   = "foo.0.bar"
		result = "quux 1"
		expect(described_class.get(data, path)).to eql result
	end

	it 'testcase 9' do
		data   = { "foo" => [ { "bar" => [ { "baz" => "quux 1" } ] }, { "bar" => [ { "baz" => "quux 2" } ] } ] }
		path   = "foo.*.bar.*.baz"
		result = ["quux 1", "quux 2"]
		expect(described_class.get(data, path)).to eql result
	end

end