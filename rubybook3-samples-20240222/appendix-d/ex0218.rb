# frozen_string_literal: true

fname = 'ex0218.output'

if(File.exist?(fname)) # <1>
  puts "ファイル#{fname}を削除します。"
  File.delete(fname) # <2>
end
puts '>----'

begin # <3>
  f = File.open(fname, 'r')
rescue => e # <4>
  p e.message # <5>
  puts "■エラー：ファイル#{fname}がみつかりません。新しく作成します。"
  f = File.open(fname, 'w+') # <6>
end
puts '>----'

# 『青森』太宰治（青空文庫）より
para = <<~PARA
  青森には、四年いました。青森中学に通っていたのです。親戚の豊田様のお家に、ずっと世話になっていました。寺町の呉服屋の、豊田様であります。豊田の、なくなった「お父（ど）さ」は、私にずいぶん力こぶを入れて、何かとはげまして下さいました。私も、「おどさ」に、ずいぶん甘えていました。
PARA

f.puts(para) # <7>
f.rewind # <8>
puts f.gets # <9>
puts '>----'

puts 'ファイルのモードを変更して、書き込み権限を奪います。'
File.chmod(0444, fname) # <10>
puts '>----'
begin
  f = File.open(fname, 'w+') 
rescue Errno::EACCES => e # <11>
  p e
  puts "■エラー：ファイル#{fname}に書き込み権限がありません。書き込み権限を与えます。"
  File.chmod(0644, fname) # <12>
  f = File.open(fname, 'a+') # <13>
end
puts '>----'

f.puts '追記モードで書き込んだので、ファイルの末尾に追加された。'
f.rewind
f.each do |line| # <14>
  puts line
end
