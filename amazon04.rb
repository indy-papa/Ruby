# frozen_string_literral: true

require 'selenium-webdriver'
require_relative './account_reader'

# abort:Ruby プログラムをエラーメッセージ付きで終了
# unless:条件が「偽」の時にその後の処理を実行する
abort 'acount file not specified.' unless ARGV.size == 1
# unless ARGV.size == 1が偽の時に以下の処理を実行
# 起動時のパラメータで取得したファイルから、
# ライブラリaccount_readerのread_accountメソッドを利用し情報を取得
account = read_account(ARGV[0])

driver = Selenium::WebDriver.for :chrome
# amazonのページを開く
driver.get 'https://www.amazon.co.jp'
# id:nav-link-accountList を検索してelementで参照可能とする
element = driver.find_element(:id, 'nav-link-accountList')
# 検索したelementの文字列表現を表示
puts element.text
# elementに対し、clickメソッドを使用してマウスのクリックを代替実行
element.click

# id:ap_email を検索してelementで参照可能とする
element = driver.find_element(:id, 'ap_email')
# send_keysにより起動パラメータで指定されたファイルからemail情報を入力
element.send_keys(account[:email])
# id:continue を検索してelementで参照可能とする
element = driver.find_element(:id, 'continue')
# elementに対し、clickメソッドを使用してマウスのクリックを代替実行
element.click
# sleepを使って10秒待機し、画面遷移を確認
sleep 10
# 終了
driver.quit
