# frozen_string_literal: true

details = { # <1>
  '249-9053000-2881416' => { # <2>
    '注文日' => '2019年12月19日',
    '合計' => '￥ 3,356',
    '明細' => ['オーデコロン 単品 80ml', '￥ 2,810', 'ハンドクリーム 無香料 単品 50g', '￥ 546'] # <3>
  },

  '249-3474742-7327824' => {
    '注文日' => '2019年12月16日',
    '合計' => '￥ 1,580',
    '明細' => ['マーカー コーン 5色 50個', '￥ 1,580']
  },
}

puts 'a)----'
details.each do |item| # <4>
  puts item
end

puts 'b)----'
details.each_pair do |key, value| # <5>
  puts '>====>'
  puts "key: #{key}"
  puts '>---->'
  value.each_pair do |key2, val2| # <6>
    printf "%-10s %s\n", "【#{key2}】", val2 # <7>
  end
end

puts 'c)----'
details['249-4549341-0555864'] = { # <8>
  '注文日' => '2019年12月15日',
  '合計' => '￥ 2,948',
  '明細' => ['見て試してわかる機械学習アルゴリズムの仕組み 機械学習図鑑', '秋庭 伸也', '￥ 2,948']
}
p details

puts 'd)----'
puts details.key?('249-3474742-7327824') # <9>

puts 'e)----'
details.delete('249-3474742-7327824') # <10>
puts details.key?('249-3474742-7327824') # <11>
p details
