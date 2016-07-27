#!/usr/bin/env ruby

require 'sqlite3'

THREASHOLD=20

db = SQLite3::Database.new( "test.db" )
whereclause= " where path like '%lib%' or path like '%bin%' and (version = '1.5.2' or version = '1.5.3') order by path"

# Get unique filenames to check
sql = "select distinct(path) from filesizes " + whereclause
filelist= []
db.execute(sql) do | row|
  filelist <<  row[0]
end

# Get all sizes
min = {}
max = {}
filelist.each do |file|
  next if (file !~ /\.a$/  and file !~/\.so$/)
  sql = "select filename, path, size, version from filesizes where path='#{file}' and (version = '1.5.2' or version = '1.5.3') order by path"
  min[:size]=nil
  min[:version]=nil
  max[:size]=0
  max[:version]=nil
  db.execute(sql) do | row|
    if min[:size].nil?
      min[:version] = row[3]
      min[:size] = row[2].to_i
    end
    if row[2].to_i > max[:size].to_i
      max[:size] = row[2].to_i
      max[:version] = row[3]
    end
  end
  if min[:size].to_f/max[:size].to_f <= 1 - (THREASHOLD * 0.01)
    puts "#{file} has min size of #{min[:size]} at version #{min[:version]} and max of #{max[:size]} at version #{max[:version]} for more than a #{THREASHOLD}% change."
  end
end
