# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "pebleak"
  s.version     = "0.0.1"
  s.authors     = ["Bjørge Næss"]
  s.email       = ["bjoerge@bengler.no"]
  s.homepage    = "https://github.com/bengler/pebleak"
  s.summary     = %q{A small gem to detect memory leak in a pebble}
  s.description = %q{A small gem to detect memory leak in a pebble}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency "httpclient"
  s.add_runtime_dependency "terminal-table"

end
