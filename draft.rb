

Validation.register_rule(:required, VanillaValidation::Rules::RequiredRule)


# ├── lib
# │   ├── vanilla_validator
# │   │   ├── validator.rb
# │   │   ├── value_extractor.rb
# │   │   ├── rule_parser.rb
# │   │   ├── rules
# │   │   │   ├── base_rule.rb
# │   │   │   ├── rule1.rb
# │   │   │   ├── rule2.rb
# │   │   ├── error_formatter.rb
# │   │   ├── result.rb
# │   ├── vanilla_validator.rb


input = {
  "foo" => 'Hello dog',
  "bar" => 'x'
}

result = VanillaValidator.validate(input, { "foo" => "required", "bar" => "numeric" })


contract = VanillaValidator.contract({
  'foo': 'required|numeric'
})

contract.(params)