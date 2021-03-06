
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "csv_splitter/version"

Gem::Specification.new do |spec|
  spec.name          = "csv_splitter"
  spec.version       = CsvSplitter::VERSION
  spec.authors       = ["Damien Pyles"]
  spec.email         = ["dpyles@yourlightingbrand.com\n"]

  spec.summary       = %q{Utility to split a CSV into multiple according based on a particular column.}
  spec.homepage      = "https://github.com/HowardSnowden/csv-splitter"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.executables   = ['csv_split'] 
  spec.require_paths = ["lib"]
  spec.add_runtime_dependency 'zaru'

  spec.add_development_dependency "bundler", "~> 1.16.a"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
