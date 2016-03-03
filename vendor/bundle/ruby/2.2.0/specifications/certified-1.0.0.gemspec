# -*- encoding: utf-8 -*-
# stub: certified 1.0.0 ruby .

Gem::Specification.new do |s|
  s.name = "certified"
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["."]
  s.authors = ["Stevie Graham"]
  s.date = "2014-07-19"
  s.description = "Ensure net/https uses OpenSSL::SSL::VERIFY_PEER to verify SSL certificates and provides certificate bundle in case OpenSSL cannot find one"
  s.email = "sjtgraham@mac.com"
  s.executables = ["certified-update"]
  s.files = ["bin/certified-update"]
  s.homepage = "http://github.com/stevegraham/certified"
  s.post_install_message = "IMPORTANT: Remember to use the included executable `certifed-update` regularly to keep your certificate bundle up to date."
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.7")
  s.rubygems_version = "2.4.8"
  s.summary = "Ensure net/https uses OpenSSL::SSL::VERIFY_PEER to verify SSL certificates and provides certificate bundle in case OpenSSL cannot find one"

  s.installed_by_version = "2.4.8" if s.respond_to? :installed_by_version
end
