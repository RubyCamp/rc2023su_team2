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
  avoid_nodes = ['e', 'g', 'h']  # 通らないノードを指定
  
  result = dijkstra(graph, 'a', 'f', avoid_nodes)
  

  if result
    puts result.join(' -> ')
  else
    puts "No path found."
  end