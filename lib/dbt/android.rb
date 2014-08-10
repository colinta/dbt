module DBT
  module Android
    module_function
    def analyze(app)
      activities = []
      files = app.files.flatten.uniq
      files.each do |filename|
        File.open(filename, 'r:UTF-8') do |file|
          file.each_line do |line|
            if line =~ /^[ \t]*#[ \t]*@(activity)/
              command, activity = line.rstrip.sub(/^[ \t]*#[ \t]*@/, '').split(' ', 2)
              app.sub_activities << activity
            end
          end
        end
      end
    end
  end
end
