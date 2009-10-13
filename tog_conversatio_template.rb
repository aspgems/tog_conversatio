plugin 'thinking-sphinx', :git => "git://github.com/freelancing-god/thinking-sphinx.git"
gem "RedCloth", :lib => "redcloth", :source => "http://code.whytheluckystiff.net"

puts "\n"
if yes?("Install required gems as root? (y/n)")
  rake "gems:install", :sudo => true
else
  rake "gems:install", :sudo => false
end

plugin 'tog_conversatio', :git => "git://github.com/tog/tog_conversatio.git"

route "map.routes_from_plugin 'tog_conversatio'"

file "db/migrate/" + Time.now.strftime("%Y%m%d%H%M%S") + "_install_tog_conversatio.rb",
%q{class InstallTogConversatio < ActiveRecord::Migration
    def self.up
      migrate_plugin "tog_conversatio", 5
    end

    def self.down
      migrate_plugin "tog_conversatio", 0 
    end
end
}

if yes?("Generate sphinx index? (only for MySQL and PostgreSQL) (y/n)")
  rake "thinking_sphinx:index"
end
rake "db:migrate"

