require 'minitest/spec'
require 'minitest/autorun'
require_relative '../lib/dbt/android'

App = Struct.new(:files, :sub_activities, :main_activity)
describe DBT::Android do
  it "will populate the sub_activities" do
    app = App.new([
      "spec/support/android.rb",
    ], [], "MainActivity")

    app.sub_activities.must_equal []
    DBT::Android.analyze(app)
    app.sub_activities.must_equal [ "MyActivity" ]
  end
end
