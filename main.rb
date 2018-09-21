# Linuxのatという決められた時刻にコマンドを実行するコマンドのようにrubyのfunctionを実行するプログラムだから
# atrufunという名前にした。
require 'time'
require 'sqlite3'

require './function.rb'
require './command.rb'

db = SQLite3::Database.new("reservation.db")
if db.execute("select * from sqlite_master;") == []
  sql = <<-SQL
    create table reservation (
      id integer primary key,
      date_time text,
      file text,
      program text
    );
  SQL
  db.execute(sql)
  puts "create database"
end
db.close

if ARGV[0] == nil
  def conversion_time(s)
    return s.gsub(":","").gsub("-","").gsub(" ","").to_i
  end

  while true
    db = SQLite3::Database.new("reservation.db")

    time_now = conversion_time(Time.now.strftime('%F %R'))
    data = db.execute("SELECT * from reservation;")

    puts time_now
    data.each do |data|
      print data
      puts
      if time_now >= conversion_time(data[1])
        `ruby main.rb do #{data[0]} &`
        db.execute("DELETE from reservation where id = #{data[0]};")
      end
    end
    puts "\n"

    db.close
    sleep rand(19.0) + 17
  end
elsif
  command()
end
