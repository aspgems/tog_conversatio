
def in_file(relative_destination, expr)
  path = destination_path(relative_destination)
  File.read(path).match(expr)
end
# add thinking-sphinx to Gemfile and update gems bundle
unless in_file('Gemfile', /thinking-sphinx/)
  append_file 'Gemfile', "gem 'thinking-sphinx',\t'1.3.3',\t:require_as => 'thinking_sphinx/0.9.8'\n"
  run 'gem bundle'
  append_file 'Rakefile', "require 'thinking_sphinx/tasks'\n"
end

plugin 'tog_conversatio', :git => "git://github.com/aspgems/tog_conversatio.git"

route "map.routes_from_plugin 'tog_conversatio'"

generate "update_tog_migration"

if yes?("Generate sphinx index? (only for MySQL and PostgreSQL) (y/n)")
 rake "thinking_sphinx:index"
end

rake "db:migrate"

