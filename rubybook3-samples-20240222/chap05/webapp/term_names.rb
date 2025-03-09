# frozen_string_literal: true

def init_term_names # <1>
  $term_names = { 'last30' => '過去30日間', 'months-3' => '過去3ヶ月' } # <2>
  (2001..Time.now.year).reverse_each do |year| # <3>
    $term_names["year-#{year}"] = "#{year}年" # <4>
  end
  $term_names['archived'] = '非表示にした注文' # <5>
end
init_term_names # <6>

if __FILE__ == $PROGRAM_NAME
  p $term_names  # <7>
end


# ruby term_names.rb > term_data.txt などとすると、init_term_namesメソッドが生成する$term_namesの中身が確認できる。
# $term_names = {
#   'last30' => '過去30日', 'months-3' => '過去3ヶ月', 'year-2021' => '2021年', 'year-2020' => '2020年',
#   'year-2019' => '2019年', 'year-2018' => '2018年', 'year-2017' => '2017年', 'year-2016' => '2016年',
#   'year-2015' => '2015年', 'year-2014' => '2014年', 'year-2013' => '2013年', 'year-2012' => '2012年',
#   'year-2011' => '2011年', 'year-2010' => '2010年', 'year-2009' => '2009年', 'year-2008' => '2008年',
#   'year-2007' => '2007年', 'year-2006' => '2006年', 'year-2005' => '2005年', 'year-2004' => '2004年',
#   'year-2003' => '2003年', 'year-2002' => '2002年', 'year-2001' => '2001年',
#   'archived' => '非表示にした注文'
# }

