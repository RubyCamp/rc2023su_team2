require_relative 'ruby-ev3/lib/ev3'
require 'dxruby'
require_relative 'map'

COLOR_SENSOR = "2"
LEFT_MOTOR = "C"
RIGHT_MOTOR = "B"
PORT = "COM3"
MOTOR_SPEED = 50

puts "starting..."
brick = EV3::Brick.new(EV3::Connections::Bluetooth.new(PORT))
brick.connect
puts "connected..."
motors = [LEFT_MOTOR, RIGHT_MOTOR]

brick.reset(*motors)   # モーターの回転方向を初期化

#1列目の色情報の取得
color_list_1=[]

brick.start(MOTOR_SPEED, *motors)
sleep 0.6
brick.stop(true, *motors)

cnt = 0
color_list_1<< brick.get_sensor(COLOR_SENSOR, 2)

brick.start(MOTOR_SPEED, *motors)
sleep 0.6
brick.stop(true, *motors)

cnt = 0
color_list_1<< brick.get_sensor(COLOR_SENSOR, 2)

brick.start(MOTOR_SPEED, *motors)
sleep 0.6
brick.stop(true, *motors)

cnt = 0

color_list_1<< brick.get_sensor(COLOR_SENSOR, 2)

brick.start(MOTOR_SPEED, *motors)
sleep 0.6
brick.stop(true, *motors)

cnt = 0

color_list_1<< brick.get_sensor(COLOR_SENSOR, 2)


#2列目の色情報の取得
color_list_2=[]

brick.start(MOTOR_SPEED, *motors)
sleep 0.6
brick.stop(true, *motors)

cnt = 0


color_list_2<< brick.get_sensor(COLOR_SENSOR, 2)

brick.start(MOTOR_SPEED, *motors)
sleep 0.6
brick.stop(true, *motors)

cnt = 0

color_list_2<< brick.get_sensor(COLOR_SENSOR, 2)

brick.start(MOTOR_SPEED, *motors)
sleep 0.6
brick.stop(true, *motors)

cnt = 0


color_list_2<< brick.get_sensor(COLOR_SENSOR, 2)

brick.start(MOTOR_SPEED, *motors)
sleep 0.6
brick.stop(true, *motors)

cnt = 0

color_list_2<< brick.get_sensor(COLOR_SENSOR, 2)

#3列目の色情報の取得
color_list_3=[]

brick.start(MOTOR_SPEED, *motors)
sleep 0.6
brick.stop(true, *motors)

cnt = 0

color_list_3<< brick.get_sensor(COLOR_SENSOR, 2)

brick.start(MOTOR_SPEED, *motors)
sleep 0.6
brick.stop(true, *motors)

cnt = 0


color_list_3<< brick.get_sensor(COLOR_SENSOR, 2)

brick.start(MOTOR_SPEED, *motors)
sleep 0.6
brick.stop(true, *motors)

cnt = 0


color_list_3<< brick.get_sensor(COLOR_SENSOR, 2)

brick.start(MOTOR_SPEED, *motors)
sleep 0.6
brick.stop(true, *motors)

cnt = 0


color_list_3<< brick.get_sensor(COLOR_SENSOR, 2)


# 回転

brick.start(MOTOR_SPEED,LEFT_MOTOR)
sleep 1.6
brick.stop(true, *motors)

#color_listの表示

new_color_list=[]

new_color_list.push color_list_1
new_color_list.push color_list_2
new_color_list.push color_list_3
p new_color_list


puts "closing..."
brick.stop(true, *motors)
brick.clear_all
brick.disconnect
puts "finished..."


Window.width = 800
Window.height = 600

map = Map.new(new_color_list)


Window.loop do
  break if Input.key_push?(K_ESCAPE)

  map.update
  map.draw

end

