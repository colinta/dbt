DBT
---

DBT (Dependencies and deBugging Tool) is a RubyMotion tool that works for iOS, OSX,
and Android to detect classes and dependencies. It will declare them in your config
so you don't have to manually manage them.

# iOS/OSX Dependency Analysis

DBT will look for `break`, `require`, and `provides` commands (and does a *teensy*
bit of code analyzing - it will detect VERY basic class and module declarations)
to make your RubyMotion `debugger_cmds` file easy to create, and declaring your file
dependencies stupid simple.

**CAUTION**: It overwrites the `debugger_cmds` file!

To use, include this gem (`gem 'dbt'`), and add `DBT.analyze(app)` to your
`Rakefile`, after you have added your own files to `app.files`.  It looks at
`app.files` and scans those files, so I mean it when I say "after you have added
your own files". In your source code you add DBT commands:

```ruby
# @provides Foo
# @requires module:Bar
class Foo
  include Bar

  def scary_method
#-----> break
    doing
    interesting
    stuff
  end

end
```

When you run `rake`, these commands will be found and translated into directives
for `app.files_dependencies` and `debugger_cmds`.  Run `rake` or `rake debug=1`,
and off you go!

Your files will be grep'd for `^\w*(class|module)`, and these will be registered
automatically as:

```ruby
# you DON'T need to add these 'provides' lines!
# @provides class:ClassName
class ClassName
end

# @provides module:ModuleName
module ModuleName
end


# @provides module:Foo
module Foo
  # Sorry, no support for Foo::Bar... I do intend to add it, though!
  #
  # @provides class:Bar
  class Bar
  end
end


# ...in another file...
# @requires class:ClassName
# @requires module:ModuleName
class AnotherClass < ClassName
  include ModuleName
end
```

So right out of the box, you can add `# @requires class:Foo` if you're having
trouble with dependencies and want a quick fix without having to add
`# @provides` declarations all over the place.

Which begs the question, *when* would you need to declare an explicit
`# @provides`?  Examples:

##### Splitting up a class across multiple files:
###### controller.rb
```ruby
# @provides Controller
class Controller < UIViewController
end
```

###### controller_table_view.rb
```ruby
# provides table view methods
#
# @requires Controller
class Controller

  def numberOfSectionsInTableView(table_view)
    1
  end

end
```

##### Not-easily-greppable syntax
```ruby
# @provides module:Foo::Bar
module Foo ; module Bar
end end
```

# Android

In Android, dependencies are handled automatically, but you need to declare your
`Android::App::Activity` classes in your config. Normally, you'd do something like
this:

```ruby
app.sub_activities = [
  "FirstActivity",
  "SecondActivity",
  # etc
]
```

With DBT, you can now add these declarations to the top of your activities:

```ruby
# @activity FirstActivity
class FirstActivity < Android::App::Activity
  # ...
end
```

That's all the functionality we have for Android at the moment, but it's pretty helpful!

# Breakpoints

Breakpoints are created using the syntax `#--> break`, with two or more dashes
before the `>`. There must not be any whitespace before or after the `#`.

```ruby
  def method
    do_something
#---> break
    do_dangerous_thing
  end

# you can also provide a line number
#--------> break 102
101:   def method
102:     do_something
103:     do_dangerous_thing
104:   end
```

If a line number is given to the `break` command, a breakpoint will be added at
*that* line, otherwise it will be added to the line below `break`.  It's better
to insert the `#--> break` where you NEED it, rather than hardcode line numbers,
since line numbers are not constant.

# Running Tests

We have two simple test files, so just run them manually.

```sh-session
$ ruby spec/ios_spec.rb && ruby spec/android_spec.rb
```
