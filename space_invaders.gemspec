lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "space_invaders/version"

Gem::Specification.new do |spec|
  spec.name          = "space_invaders"
  spec.version       = SpaceInvaders::Version
  spec.authors       = "Rubies on da Cloud"

  spec.description   = %q{Space Invaders is a game where you try to defeat waves of aliens with a laser cannon to earn as many points as possible. It was originally developed as an arcade by Tomohiro Nishikado in 1978.}
  spec.summary       = %q{An implementation of the Space Invaders game, written using the Gosu framework}
  spec.homepage      = "https://github.com/RubiesOnDaCloud/space_invaders"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(spec)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "gosu", "~> 0.9.2"
  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.4"
  spec.add_development_dependency "rspec", "~> 3.3"
end
