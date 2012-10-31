Analizaruptor
-------------

Analizaruptor is a tool that looks 'require', and 'provides' commands (and does
a *teensy* bit of code analyzing (`/(class|module)\s*(\w`)/`) to provide some
defaults) to make your RubyMotion `Rakefile` and `debugger_cmds` files short and
consistent.

To use, include this gem, and add `app.analyze` to your `Rakefile`, after you
have added your libraries and whatnot.  In your source code you can add
Analizaruptor commands (`#----> break|provides|requires`) and those will be
translated into directives for `app.files_dependencies` and `debugger_cmds`.

Run `rake` or `rake debug=1`, and off you go!
