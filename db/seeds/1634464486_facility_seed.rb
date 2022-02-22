Facility.destroy_all

Facility.create!([
  { id: 1, name: "個室（壁・扉あり）", facility_category_id: 1 },
  { id: 2, name: "トイレ", facility_category_id: 1 },
  { id: 3, name: "電源", facility_category_id: 1 },
  { id: 4, name: "エアコン（冷暖房）", facility_category_id: 1 },
  { id: 5, name: "キッチン設備", facility_category_id: 1 },
  { id: 6, name: "飲食可", facility_category_id: 1 },
  { id: 7, name: "飲酒可", facility_category_id: 1 },
  { id: 8, name: "片付けおまかせ", facility_category_id: 1 },
  { id: 9, name: "ゴミ処理おまかせ", facility_category_id: 1 },
  { id: 10, name: "Wi-Fi（光回線）", facility_category_id: 1 },
  { id: 11, name: "Wi-Fi（モバイル）", facility_category_id: 1 },
  { id: 12, name: "Wi-Fi（その他）", facility_category_id: 1 },
  { id: 13, name: "換気可（窓・換気扇あり）", facility_category_id: 2 },
  { id: 14, name: "スタッフによる毎回清掃", facility_category_id: 2 },
  { id: 15, name: "毎回除菌・消毒", facility_category_id: 2 },
  { id: 16, name: "除菌グッズ設置", facility_category_id: 2 },
  { id: 17, name: "アクリル板", facility_category_id: 2 },
  { id: 18, name: "駅まで徒歩10分以内", facility_category_id: 3 },
  { id: 19, name: "周辺にスーパー/コンビニ", facility_category_id: 3 },
  { id: 20, name: "周辺に飲食店", facility_category_id: 3 },
  { id: 21, name: "駐車場", facility_category_id: 3 },
  { id: 22, name: "公共交通機関", facility_category_id: 3 },
  { id: 23, name: "スペース外に喫煙所", facility_category_id: 3 },
  { id: 24, name: "自然光", facility_category_id: 4 },
  { id: 25, name: "三脚", facility_category_id: 4 },
  { id: 26, name: "商用撮影可", facility_category_id: 4 },
  { id: 27, name: "レフ板", facility_category_id: 4 },
  { id: 28, name: "アンブレラ", facility_category_id: 4 },
  { id: 29, name: "白ホリゾント", facility_category_id: 4 },
  { id: 30, name: "Rホリゾント", facility_category_id: 4 },
  { id: 31, name: "LEDライト", facility_category_id: 4 },
  { id: 32, name: "ビデオライト", facility_category_id: 4 },
  { id: 33, name: "ストロボ", facility_category_id: 4 },
  { id: 34, name: "バックペーパ", facility_category_id: 4 },
  { id: 35, name: "ソフトボックス", facility_category_id: 4 },
  { id: 36, name: "写真撮影機材", facility_category_id: 4 },
  { id: 37, name: "動画撮影機材", facility_category_id: 4 },
  { id: 38, name: "トルソー（マネキン）", facility_category_id: 4 },
  { id: 39, name: "エレベーター", facility_category_id: 5 },
  { id: 40, name: "防音", facility_category_id: 5 },
  { id: 41, name: "フローリング", facility_category_id: 5 },
  { id: 42, name: "和室・畳", facility_category_id: 5 },
  { id: 43, name: "バリアフリー対応", facility_category_id: 5 },
  { id: 44, name: "テラス・ベランダ", facility_category_id: 5 },
  { id: 45, name: "屋上", facility_category_id: 5 },
  { id: 46, name: "庭", facility_category_id: 5 },
  { id: 47, name: "屋外", facility_category_id: 5 },
  { id: 48, name: "半個室（パーティション等で仕切られたスペース）", facility_category_id: 5 },
  { id: 49, name: "オープンスペース（仕切りがない共同スペース）", facility_category_id: 5 },
  { id: 50, name: "プール", facility_category_id: 5 },
  { id: 51, name: "シャワー", facility_category_id: 5 },
  { id: 52, name: "バスタブ", facility_category_id: 5 },
  { id: 53, name: "洗濯機", facility_category_id: 5 },
  { id: 54, name: "乾燥機", facility_category_id: 5 },
  { id: 55, name: "着替えスペース", facility_category_id: 5 },
  { id: 56, name: "ロッカー", facility_category_id: 5 },
  { id: 57, name: "クローク", facility_category_id: 5 },
  { id: 58, name: "メイクスペース", facility_category_id: 5 },
  { id: 59, name: "カラオケ", facility_category_id: 5 },
  { id: 60, name: "ダンス用鏡", facility_category_id: 5 },
  { id: 61, name: "レッスンバー", facility_category_id: 5 },
  { id: 62, name: "リノリウム床", facility_category_id: 5 },
  { id: 63, name: "バーカウンター", facility_category_id: 5 },
  { id: 64, name: "路面店", facility_category_id: 5 },
  { id: 65, name: "音響設備", facility_category_id: 5 },
  { id: 66, name: "照明設備", facility_category_id: 5 },
  { id: 67, name: "天井高3m以上", facility_category_id: 5 },
  { id: 68, name: "防犯カメラあり", facility_category_id: 5 },
  { id: 69, name: "有線インターネット（光回線）", facility_category_id: 5 },
  { id: 70, name: "有線インターネット（その他）", facility_category_id: 5 },
  { id: 71, name: "テーブル", facility_category_id: 6 },
  { id: 72, name: "椅子", facility_category_id: 6 },
  { id: 73, name: "ソファ", facility_category_id: 6 },
  { id: 74, name: "ハンガーラック", facility_category_id: 6 },
  { id: 75, name: "テレビ", facility_category_id: 6 },
  { id: 76, name: "二面鏡", facility_category_id: 6 },
  { id: 77, name: "DVD・Blu-rayプレイヤー", facility_category_id: 6 },
  { id: 78, name: "全身鏡", facility_category_id: 6 },
  { id: 79, name: "ミラー", facility_category_id: 6 },
  { id: 80, name: "無線マイク", facility_category_id: 6 },
  { id: 81, name: "有線マイク", facility_category_id: 6 },
  { id: 82, name: "アンプ・スピーカー", facility_category_id: 6 },
  { id: 83, name: "脚立", facility_category_id: 6 },
  { id: 84, name: "調理器具", facility_category_id: 7 },
  { id: 85, name: "電子レンジ", facility_category_id: 7 },
  { id: 86, name: "冷蔵庫", facility_category_id: 7 },
  { id: 87, name: "たこ焼き器", facility_category_id: 7 },
  { id: 88, name: "ホットプレート", facility_category_id: 7 },
  { id: 89, name: "鍋", facility_category_id: 7 },
  { id: 90, name: "BBQコンロ", facility_category_id: 7 },
  { id: 91, name: "ホワイトボード", facility_category_id: 8 },
  { id: 92, name: "プロジェクター・スクリーン", facility_category_id: 8 },
  { id: 93, name: "延長コード", facility_category_id: 8 },
  { id: 94, name: "HDMIケーブル", facility_category_id: 8 },
  { id: 95, name: "パソコン", facility_category_id: 8 },
  { id: 96, name: "モニター", facility_category_id: 8 },
  { id: 97, name: "プリンタ", facility_category_id: 8 },
  { id: 98, name: "RGBケーブル", facility_category_id: 8 },
  { id: 99, name: "ローラー付き椅子", facility_category_id: 8 },
  { id: 100, name: "展示棚", facility_category_id: 9 },
  { id: 101, name: "司会台", facility_category_id: 9 },
  { id: 102, name: "ヨガマット", facility_category_id: 9 },
  { id: 103, name: "ピアノ", facility_category_id: 9 },
  { id: 104, name: "ダーツ", facility_category_id: 9 },
  { id: 105, name: "マッサージ用ベッド", facility_category_id: 9 },
  { id: 106, name: "スモークマシン", facility_category_id: 9 },
  { id: 107, name: "ハンディブロワ", facility_category_id: 9 },
  { id: 108, name: "子ども連れ可", facility_category_id: 10 },
  { id: 109, name: "ベビーカー持込可", facility_category_id: 10 },
  { id: 110, name: "スタッフ常駐", facility_category_id: 10 },
  { id: 111, name: "事前荷物預かり", facility_category_id: 10 },
  { id: 112, name: "調理可", facility_category_id: 10 },
  { id: 113, name: "楽器演奏可", facility_category_id: 10 },
  { id: 114, name: "喫煙可", facility_category_id: 10 },
  { id: 115, name: "電子タバコ可", facility_category_id: 10 },
  { id: 116, name: "弁当・ドリンク依頼可", facility_category_id: 10 },
  { id: 117, name: "ケータリング", facility_category_id: 10 },
  { id: 118, name: "レイアウト変更依頼可", facility_category_id: 10 },
  { id: 119, name: "夜22時以降利用可", facility_category_id: 10 },
  { id: 120, name: "土足可", facility_category_id: 10 },
  { id: 121, name: "ペット可", facility_category_id: 10 },
  { id: 122, name: "TV会議サービス", facility_category_id: 10 },
  { id: 123, name: "飲食店営業許可取得済み", facility_category_id: 10 },
  { id: 124, name: "菓子製造許可取得済み", facility_category_id: 10 },
])
