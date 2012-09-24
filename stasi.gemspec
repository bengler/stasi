# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "stasi/version"

Gem::Specification.new do |s|
  s.name        = "stasi"
  s.version     = Stasi::VERSION
  s.authors     = ["Bjørge Næss"]
  s.email       = ["bjoerge@bengler.no"]
  s.homepage    = "https://github.com/bengler/stasi"
  s.summary     = %q{A small gem to detect memory leak in a pebble}
  s.description = %q{A small gem to detect memory leak in a pebble}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "httpclient"
  s.add_dependency "bundler"
  s.add_dependency "term-ansicolor"

end
