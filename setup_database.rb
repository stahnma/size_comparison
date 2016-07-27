

require 'json'

j = JSON.parse(File.read('output.json'))

sql = "CREATE TABLE filesizes(filename string, path string, size bigint, version string);\n"
j.each do |item|
  filename  = item['name'].split('/')[-1]
  sql << "insert into filesizes (filename, path, size, version) values ('#{filename}', '#{item['name'].to_s}', #{item['size'].to_s}, '#{item['version'].to_s}');\n"
end

# pretty much just run this and capture stdout to a file
# then run something like sqlite3 testdb < sql
puts sql
