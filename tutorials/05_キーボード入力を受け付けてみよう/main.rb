require 'dxruby'

Window.width = 800
Window.height = 600

player_img = Image.load("images/character.png")

px = 0
py = 0

Window.loop do
  break if Input.key_push?(K_ESCAPE)  # ESCキーが押下された場合、メインループを抜ける（＝この場合はプログラムを終了する）

  Window.draw(px, py, player_img)
  px += Input.x # 本フレーム実行時点における「←」「→」キーやゲームパッドの左右入力状態を判定し、「-1」（左押下）「1」（右押下）「0」（どちらも押されていない）のいずれかで返す。
  py += Input.y # 本フレーム実行時点における「↑」「↓」キーやゲームパッドの上下入力状態を判定し、「-1」（上押下）「1」（下押下）「0」（どちらも押されていない）のいずれかで返す。
end
