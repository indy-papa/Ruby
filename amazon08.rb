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

# WebDriverの初期化。forのパラメータにブラウザとしてchromeの使用を指示。
driver = Selenium::WebDriver.for :chrome
# Watクラスのインスタンスwaiteを作成。タイムアウト時間は20秒に設定
wait = Selenium::WebDriver::Wait.new(timeout: 20)
# Waitクラスのuntilメソッドは、引数に受け取ったブロックの処理がtrueを返すまで
# 次の処理を待つ

# amazonのページを開く
driver.get 'https://www.amazon.co.jp'
# id:nav-link-accountList を検索してelementで参照可能とする
element = driver.find_element(:id, 'nav-link-accountList')
# 検索したelementの文字列表現を表示
puts element.text
# elementに対し、clickメソッドを使用してマウスのクリックを代替実行
element.click

# 表示待ち
wait.until { driver.find_element(:id, 'ap_email').displayed? }
puts driver.title
# id:ap_email を検索してelementで参照可能とする
element = driver.find_element(:id, 'ap_email')
# send_keysにより起動パラメータで指定されたファイルからemail情報を入力
element.send_keys(account[:email])
# id:continue を検索してelementで参照可能とする
element = driver.find_element(:id, 'continue')
# elementに対し、clickメソッドを使用してマウスのクリックを代替実行
element.click

# ap_passwordのidが表示されるまで待つ
wait.until { driver.find_element(:id, 'ap_password').displayed? }
# id:ap_password を検索してelementで参照可能とする
element = driver.find_element(:id, 'ap_password')
# send_keysにより起動パラメータで指定されたファイルからpassword情報を入力
element.send_keys(account[:password])

# ログインボタンのid:auth-signin-button を検索してelementで参照可能とする
element = driver.find_element(:id, 'auth-signin-button')
# elementに対し、clickメソッドを使用してマウスのクリックを代替実行
element.click
# amazonのサイトを最初に表示した時に検索したnav_link_accountListのidが
# 表示されるまで待機
wait.until { driver.find_element(:id, 'nav-link-accountList').displayed? }

# ============================================================
# リスト2.46で追加
# ============================================================
# 注文履歴のid:nav-ordersを検索してelementで参照可能とする
element = driver.find_element(:id, 'nav-orders')
# elementに対し、clickメソッドを使用してマウスのクリックを代替実行
element.click
# id:navFooterが表示されるまで待機
wait.until { driver.find_element(:id, 'navFooter').displayed? }
# ページタイトルを画面に表示
puts driver.title

# ============================================================
# リスト2.49で追加
# ============================================================
# 注文履歴ページの取得期間ｾﾚｸﾄボックスid:time-filterを検索してyearsで参照可能とする
years = driver.find_element(:id, 'time-filter')
# 参照可能としたyearsに対する選択肢リストを作成
# <select>タグ要素の<option>タグの情報を選択肢リストselectとして作成
select = Selenium::WebDriver::Support::Select.new(years)
# 該当するvalueを指定して選択実行
select.select_by(:value, 'year-2024')
# id:navFooterが表示されるまで待機
wait.until { driver.find_element(:id, 'navFooter').displayed? }

# ============================================================
# リスト2.57で追加
# ============================================================
# 検索するセレクタを参照可能とする
selector = '#a-page .a-box.delivery-box .a-fixed-left-grid-col.a-col-right > div:nth-child(1)'
# cssセレクタを指定したfind_elementsを使用して複数の注文品名を検索
titles = driver.find_elements(:css, selector)
# 検索された注文品名の数を表示
puts titles.size
# 検索結果の各々についてtextを使用してテキストを取得表示
titles.map { |t| puts t.text }

# sleepを使って10秒待機し、画面遷移を確認
sleep 10
# 終了
driver.quit
