# frozen_string_literal: true

require_relative "lib/parasol/version"

Gem::Specification.new do |spec|
  spec.name = "parasol"
  spec.version = Parasol::VERSION
  spec.authors = ["John DeSilva"]
  spec.email = ["john@aesthetikx.info"]

  spec.summary = "A Ruby Shader Library"
  spec.description = spec.summary
  spec.homepage = "https://www.github.com/Aesthetikx/parasol"
  spec.license = "Unlicense"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://www.github.com/aesthetikx/parasol"
  spec.metadata["changelog_uri"] = "https://www.github.com/aesthetikx/parasol/blob/master/CHANGELOG.md"
  spec.metadata["rubygems_mfa_required"] = "true"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "opengl-bindings2", "~> 2"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
