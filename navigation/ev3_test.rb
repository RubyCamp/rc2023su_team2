require_relative 'ruby-ev3/lib/ev3'
require_relative 'map'

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

brick.start(MOTOR_SPEED, *motors)
sleep 0.65
brick.stop(true, *motors)

brick.start(MOTOR_SPEED, *motors)
sleep 0.65
brick.stop(true, *motors)

cnt = 0
color_list_1<< brick.get_sensor(COLOR_SENSOR, 2)

brick.start(MOTOR_SPEED, *motors)
sleep 0.65
brick.stop(true, *motors)

cnt = 0

color_list_1<< brick.get_sensor(COLOR_SENSOR, 2)

brick.start(MOTOR_SPEED, *motors)
sleep 0.65
brick.stop(true, *motors)

cnt = 0

color_list_1<< brick.get_sensor(COLOR_SENSOR, 2)

#2列目の色情報の取得
color_list_2=[]

# 回転

brick.start(MOTOR_SPEED,RIGHT_MOTOR)
sleep 1.57
brick.stop(true, *motors)

color_list_2<< brick.get_sensor(COLOR_SENSOR, 2)

brick.start(MOTOR_SPEED, *motors)
sleep 0.65
brick.stop(true, *motors)

cnt = 0


color_list_2<< brick.get_sensor(COLOR_SENSOR, 2)

brick.start(MOTOR_SPEED, *motors)
sleep 0.65
brick.stop(true, *motors)

cnt = 0

color_list_2<< brick.get_sensor(COLOR_SENSOR, 2)

brick.start(MOTOR_SPEED, *motors)
sleep 0.65
brick.stop(true, *motors)

cnt = 0


color_list_2<< brick.get_sensor(COLOR_SENSOR, 2)


#3列目の色情報の取得
color_list_3=[]

# 回転

brick.start(MOTOR_SPEED,LEFT_MOTOR)
sleep 1.55
brick.stop(true, *motors)

color_list_3<< brick.get_sensor(COLOR_SENSOR, 2)

brick.start(MOTOR_SPEED, *motors)
sleep 0.65
brick.stop(true, *motors)

cnt = 0

color_list_3<< brick.get_sensor(COLOR_SENSOR, 2)

brick.start(MOTOR_SPEED, *motors)
sleep 0.65
brick.stop(true, *motors)

cnt = 0


color_list_3<< brick.get_sensor(COLOR_SENSOR, 2)

brick.start(MOTOR_SPEED, *motors)
sleep 0.65
brick.stop(true, *motors)

cnt = 0


color_list_3<< brick.get_sensor(COLOR_SENSOR, 2)


#color_listの表示


color_list_2_new = color_list_2.reverse

new_color_list=[]

new_color_list.push color_list_1
new_color_list.push color_list_2_new
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





#color_listの表示

new_color_list=[]
algo_color_list=[]vv

new_color_list.push color_list_1
new_color_list.push color_list_2
new_color_list.push color_list_3
p new_color_list

algo_color_list.concat(color_list_1)
algo_color_list.concat(color_list_2)
algo_color_list.concat(color_list_3)


puts "closing..."
brick.stop(true, *motors)
brick.clear_all
brick.disconnect
puts "finished..."




#アルゴリズム

def weight(u, v, edges)
    edges[u].find { |x| x[0] == v }[1]
  end
  
  def dijkstra(graph, s, g, avoid_nodes = [])
    d = [Float::INFINITY] * graph.size
    prev = [nil] * graph.size
    q = graph.dup
    d[graph.index(s)] = 0
  
    while !q.empty?
      min_index = d.each_with_index.min[1]
      u = q[min_index]
      q.delete_at(min_index)
      $edges[u].each do |v, _|
        next if avoid_nodes.include?(v)
        v_index = graph.index(v)
        target_d = d[graph.index(u)] + weight(u, v, $edges)
        if d[v_index] > target_d
          d[v_index] = target_d
          prev[v_index] = u
        end
      end
    end
  
    shortest_path = []
    index_of_g = graph.index(g)
    until index_of_g.nil?
      shortest_path.unshift(graph[index_of_g])
      index_of_g = graph.index(prev[index_of_g])
    end
  
    shortest_path
  end
  #緑が３赤が５青が２しろが６
  $edges = {
      'a' => [['b', 0], ['h', 0]],
      'b' => [['a', 0], ['c', 0], ['g', 0]],
      'c' => [['b', 0], ['f', 0], ['d', 0]],
      'd' => [['c', 0], ['e', 0]],
      'e' => [['d', 0], ['f', 0], ['l', 0]],
      'f' => [['c', 0], ['g', 0], ['e', 0], ['k', 0]],
      'g' => [['b', 0], ['f', 0], ['h', 0], ['j', 0]],
      'h' => [['a', 0], ['g', 0], ['i', 0]],
      'i' => [['h', 0], ['j', 0]],
      'j' => [['g', 0], ['i', 0], ['k', 0]],
      'k' => [['f', 0], ['j', 0], ['l', 0]],
      'l' => [['e', 0], ['k', 0]],
  }
  
  graph = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l']
  matching_indices = algo_color_list.each_index.select { |i| algo_color_list[i] == 2 }
  matching_elements = matching_indices.map { |index| graph[index] }
  
  avoid_nodes=[]
  avoid_nodes.push(matching_elements)
  p avoid_nodes
  
  
  result = dijkstra(graph, 'a', 'f', avoid_nodes)
  

  if result
    puts result.join(' -> ')
  else
    puts "No path found."
  end
