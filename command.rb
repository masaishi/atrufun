def command()
  case ARGV[0]
  when "add"
    puts "処理を予約する\n"

    db = SQLite3::Database.new("reservation.db")
    argument = {}

    if ARGV[1] == nil
      argument[1] = get_value("日にちを入力してください 例: 2006-02-19")
      argument[2] = get_value("時間を入力してください 例: 08:12")
      argument[3] = get_value("読み込みたいものを入力してください")
      argument[4] = get_value("実行したい処理を入力してください")

    else
      argument[1] = ARGV[1]
      argument[2] = ARGV[2]
      argument[3] = ARGV[3]
      for i in (4..ARGV.size) do
        argument[4] = "#{ARGV[i]} ".gsub("<","\<").gsub(">","\>").gsub(".","\.").gsub(",","\,").gsub("/","\/").gsub("+","\+").gsub(";","\;")
      end
    end

    db.execute("insert into reservation(date_time, file, program) values('#{argument[1]} #{argument[2]}', '#{argument[3]}', '#{argument[4]}');")
    puts db.execute("SELECT * from reservation;")

    db.close
  when "do"
    db = SQLite3::Database.new("reservation.db")
    data = db.execute("SELECT * from reservation;")
    data = data[(ARGV[0].to_i) - 1]


    eval("puts data[3]")
    eval("require './extensions/#{data[2]}.rb'; #{data[3]}")
    db.close
  end
end
