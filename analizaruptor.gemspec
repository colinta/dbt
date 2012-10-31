# -*- encoding: utf-8 -*-
require File.expand_path('../lib/analizaruptor/version.rb', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = 'analizaruptor'
  gem.version       = Analizaruptor::VERSION
  gem.email         = 'colinta@gmail.com'

  gem.authors  = ['Colin Thomas-Arnold <colinta@gmail.com>']

  gem.description = <<-DESC
Analizaruptor is a tool that looks 'require', and 'provides' commands (and does
a *teensy* bit of code analyzing (+/(class|module)\s*(\w+)/+) to provide some
defaults) to make your RubyMotion +Rakefile+ and +debugger_cmds+ files short and
consistent.

To use, include this gem, and add +app.analyze+ to your +Rakefile+, after you
have added your libraries and whatnot.  In your source code you can add
Analizaruptor commands (+#----> break|provides|requires+) and those will be
translated into directives for `app.files_dependencies` and `debugger_cmds`.

Run +rake+ or +rake debug=1+, and off you go!
DESC

  gem.summary = 'Keep your Rakefile and debugger_cmds files short and consistent'
  gem.homepage = 'https://github.com/colinta/analizaruptor'

  gem.files       = `git ls-files`.split($\)
  gem.require_paths = ['lib']
  gem.test_files  = gem.files.grep(%r{^spec/})

  gem.add_dependency 'rake'
  gem.add_development_dependency 'rspec'

end
