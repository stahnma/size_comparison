

require 'json'
require 'sqlite3'
require 'awesome_print'


j = JSON.parse(File.read('output.json'))
db = SQLite3::Database.new( "test.db" )

sql = "CREATE TABLE filesizes(filename string, path string, size bigint, version string);\n"
j.each do |item|
#  ap item
  filename  = item['name'].split('/')[-1]
  sql << "insert into filesizes (filename, path, size, version) values ('#{filename}', '#{item['name'].to_s}', #{item['size'].to_s}, '#{item['version'].to_s}');\n"

end
puts sql

