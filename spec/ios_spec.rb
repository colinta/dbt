require 'minitest/spec'
require 'minitest/autorun'
require_relative '../lib/dbt/ios'

class App
  attr_accessor :files
  def files_dependencies(deps=nil)
    @deps = deps if deps
    @deps
  end
end

describe DBT::IOS do
  it "will add the right file dependencies" do
    app = App.new
    app.files = [
      "spec/support/ios.rb",
      "spec/support/ios_dependency.rb",
    ]
    DBT::IOS.analyze(app)
    app.files_dependencies.must_equal({
      "spec/support/ios.rb" => ["spec/support/ios_dependency.rb"],
    })
  end
  # TODO: others
end
