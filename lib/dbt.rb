# coding: utf-8
require 'dbt/version'
require 'dbt/android'
require 'dbt/ios'

module DBT
  module_function
  def analyze(app)
    android = app.respond_to?(:main_activity)
    DBT::Android.analyze(app) if android
    DBT::IOS.analyze(app) unless android
  end
end


Motion::Project::App.setup do |app|
  def app.analyze
    puts("\033[1mcalling `app.analyze` is deprecated.  Use DBT.analyze(app) instead (non-polluting)\033[0m")
    DBT.analyze(self)
  end
end
