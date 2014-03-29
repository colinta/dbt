# -*- encoding: utf-8 -*-
require File.expand_path('../lib/dbt/version.rb', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = 'dbt'
  gem.version       = DBT::VERSION
  gem.email         = 'colinta@gmail.com'
  gem.licenses      = ['BSD']

  gem.authors  = ['Colin Thomas-Arnold <colinta@gmail.com>']
  gem.email   = ['colinta@gmail.com']

  gem.description = <<-DESC
==DBT (Dependencies and deBugging Tool) is a tool that helps declare and declare
dependencies (+app.files_dependencies+), and assists with debugging, in
RubyMotion project. It looks for 'break', 'requires', and 'provides' commands
(it does a *teensy* bit of code analyzing to provide some defaults) to make your
RubyMotion +Rakefile+ and +debugger_cmds+ files short and consistent.

To use, include this gem, and add +app.analyze+ to your +Rakefile+ in the
+Motion::Project::App.setup+ block.  In your source code you can add DBT
commands and those will be translated into directives for
+app.files_dependencies+ and +debugger_cmds+.

Run +rake+ or +rake debug=1+, and off you go!
DESC

  gem.summary = 'Keep your Rakefile and debugger_cmds files short and consistent'
  gem.homepage = 'https://github.com/colinta/dbt'

  gem.files       = `git ls-files`.split($\)
  gem.require_paths = ['lib']
  gem.test_files  = gem.files.grep(%r{^spec/})
end
