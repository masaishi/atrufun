# Linuxのatという決められた時刻にコマンドを実行するコマンドのようにrubyのfunctionを実行するプログラムだから
# atrufunという名前にした。
require 'time'
require 'sqlite3'


db = SQLite3::Database.new("reservation.db")
if db.execute("select * from sqlite_master;") == []
  sql = <<-SQL
    create table reservation (
      id integer primary key,
      date_time text,
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

  loop do
    db = SQLite3::Database.new("reservation.db")
    timeNow =  conversion_time(Time.now.strftime('%F %R'))
    datas = db.execute("SELECT * from reservation;")
    print datas + "\n"
    will_do = []

    datas.each do |data|
      `ruby main.rb do #{data[0]}` if timeNow > conversion_time(data[1])
    end

    db.close
    sleep rand(20.0) + 17
  end
elsif
  require './command.rb'
end
