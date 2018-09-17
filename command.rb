case ARGV[0]
when "add"
  puts "add"
  db = SQLite3::Database.new("reservation.db")

  arg_all = ""
  for i in (3..ARGV.size) do
    arg_all = "#{arg_all}#{ARGV[i]} "
  end
  db.execute("insert into reservation(date_time, program) values('#{ARGV[1]} #{ARGV[2]}', '#{arg_all}');")
  puts db.execute("SELECT * from reservation;")

  db.close


when "do"
  eval("require \"./extensions/#{ARGV[1]}.rb\";#{datas[ARGV[2].to_i-1][2]}")
end
