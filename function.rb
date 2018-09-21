def get_value(show_text)
  puts "#{show_text}"
  # そのうち指定した書式にあってなかったらもう一度入力を促す機能を作る。
  return STDIN.gets.chomp
end
