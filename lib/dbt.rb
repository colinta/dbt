# coding: utf-8

Motion::Project::App.setup do |app|
  def app.analyze
    debugger_cmds_output = "#------> Creado por el Analizarruptor <------#\n"
    dependers = Hash.new { |hash,key| hash[key] = [] }
    providers = {}

    files.uniq!
    files.each do |filename|
      File.open(filename, 'r') do |file|
        file.each_line do |line|
          command = false

          if line =~ /^#--+>/
            command, dep = line.rstrip.sub(/^#--+> */, '').split(' ', 2)
          elsif line =~ /^#[ \t]*@(provides|requires)/
            command, dep = line.rstrip.sub(/^#[ \t]*@/, '').split(' ', 2)
          end

          if command
            case command
            when 'break'
              dep ||= file.lineno + 1
              debugger_cmds_output += "break #{File.basename filename}:#{dep}\n"
            when 'provides'
              if providers.key? dep
                puts "\033[1m!HAY DEMASIADOS!\033[0m \033[1;31m#{dep}\033[0m"
              end
              providers[dep] = filename
            when 'requires'
              dependers[filename] << dep
            else
              puts "\033[1m!NO COMPRENDO!\033[0m \"#{command} #{dep}\""
              puts "\033[1;31m#{filename}:#{file.lineno}\033[0m"
            end
          elsif line =~ /^\s*class\s+(\w+)/
            dep = "class:#{$1}"
            providers[dep] = filename
          elsif line =~ /^\s*module\s+(\w+)/
            dep = "module:#{$1}"
            providers[dep] = filename
          end
        end
      end
    end # files

    dependers.each do |filename, dependencies|
      if dep = dependencies.find { |dep| ! providers.include? dep }
        puts "\033[1m!NO HAY!\033[0m \033[1;31m#{dep}\033[0m"
        raise "#{filename} could not find a provider for #{dep}"
      else
        self.files_dependencies filename => dependencies.map{|dep| providers[dep] }
      end
    end

    unless debugger_cmds_output.empty?
      File.open('debugger_cmds', 'w') do |file|
        file.write debugger_cmds_output
      end
    end
  end
end
