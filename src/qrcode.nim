## http://www.swetake.com/qrcode/qr2.html
## http://www.tech-jp.com/QRCode/ModeIndicator.html

type
  QrQcode* = ref object
  QrMode* = enum ## 4bit (固定)
    qmNumeric = 0'u8
    qmAlphaNumeric = 1 shl 1
    qmByte8Bit = 1 shl 2
    qmKanji = 1 shl 3 ## 実装しない
  QrErrorCorrectLevel* = enum ## エラー訂正レベル
    qeclM = 0
    qeclL = 1
    qeclH = 2
    qeclQ = 3
  
proc split2(text: string): seq[string] =
  var s: string
  for i, c in text:
    s.add c
    if (i+1) mod 2 == 0:
      result.add s
      s = ""
  if s != "":
    result.add s

proc newQrCode*(text: string): QrQcode =
  ## QRコードを生成する。
  discard
  # データを8bit単位のコード語に変換する。
  # バージョン１、誤り訂正レベルH
  let data = "ABCDE123"
  # データの長さを9bitで表現
  let dataLength = data.len.uint16
  # データの符号化
  # 英数字モードでは2桁で区切り、1文字目を45倍する。
  # 算出された値を11bitで表現する。
  # データが1桁の場合は6bit
  var encodedData: seq[uint16]
  for s in data.split2:
    let b = if s.len == 2: s[0].uint16 * 45 + s[1].uint16
            else: s[0].uint16
    encodedData.add b
  # 終端パターンの追加
  encodedData.add 0b0000
  # QRCodeモデル2では8bitごとにデータを区切る