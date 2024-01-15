# frozen_string_literal: true

require_relative "lib/vanilla_validator/version"

Gem::Specification.new do |spec|
  spec.name = "vanilla_validator"
  spec.version = VanillaValidator::VERSION
  spec.authors = ["Farid Mohammadi"]
  spec.email = ["1997farid.mohammadi@gmail.com"]

  spec.summary = "Easy to use ruby validator"
  spec.description = "Simple and easy to use validator inspired by Laravel Validator"
  spec.homepage = "https://github.com/leurias/vanilla_validator"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/leurias/vanilla_validator"
  spec.metadata["changelog_uri"] = "https://github.com/leurias/vanilla_validator/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.extra_rdoc_files = ['README.md']

  spec.add_runtime_dependency 'i18n'
  spec.add_development_dependency 'rspec', "~> 3.2"
  spec.add_dependency 'zeitwerk', "~> 2.5"
  spec.add_dependency 'activesupport'
end
