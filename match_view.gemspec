
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "match_view/version"

Gem::Specification.new do |spec|
  spec.name          = "match_view"
  spec.version       = MatchView::VERSION
  spec.authors       = ["Cainã Costa"]
  spec.email         = ["cacosta@redhat.com"]

  spec.summary       = %q{Generalistic view layer to match and present incoming data}
  spec.homepage      = "https://github.com/cfcosta/match_view"
  spec.license       = "MIT"

  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport", "~> 4"

  spec.add_development_dependency "bundler", "~> 1.16.a"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rspec-given", "~> 3.8"
  spec.add_development_dependency "pry-byebug", "~> 3.5"
end
