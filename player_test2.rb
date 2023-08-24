class PlayerTest2


    LEFT_MOTOR = "C"
    RIGHT_MOTOR = "B"
    ARM_MOTOR = "B"
    CLAW_MOTOR = "C"
    DISTANCE_SENSOR = "4"
    PORT = "COM3"
    WHEEL_SPEED = 50
    ARM_SPEED = 10
    DEGRESS_OPEN_CLAW = 4500
    DEGRESS_CLOSE_CLAW = DEGRESS_OPEN_CLAW + 500
    CLAW_POWER = 30
  
    attr_reader :distance
  
    def initialize
      @brick = EV3::Brick.new(EV3::Connections::Bluetooth.new(PORT))
      @brick.connect
      @busy = false
      @grabbing = false
    end
  
    # 前進する
    def run_forward(speed=WHEEL_SPEED)
      operate do
        @brick.reverse_polarity(*wheel_motors)
        @brick.start(speed, *wheel_motors)
      end
    end
  
    # バックする
    def run_backward(speed=WHEEL_SPEED)
      operate do
        @brick.start(speed, *wheel_motors)
      end
    end
  
    # 右に回る
    def turn_right2(speed=WHEEL_SPEED)
      operate do
        @brick.reverse_polarity(RIGHT_MOTOR)
        @brick.start(speed, *wheel_motors)
      end
    end
  
    # 左に回る
    def turn_left2(speed=WHEEL_SPEED)
      operate do
        @brick.reverse_polarity(LEFT_MOTOR)
        @brick.start(speed, *wheel_motors)
      end
    end

  # 0だと上
  # 1だと右
  # 2だと下
  # 3だと左

  def initialize(direction,x,y,route)
    @direction = direction
    @direction_2 = @direction + 1
    @x = x
    @y = y
    @route = route
    @current_index = 0
  end

  def next
    puts @x

    current_route = @route[@current_index]
    puts current_route.inspect
    next_route = @route[@current_index + 1]
    puts next_route.inspect

    @current_index = @current_index + 1
    @current_x = current_route[0]
    @next_x = next_route[0]
    @current_y = current_route[1]
    @next_y = next_route[1]

    #ｘだけ増加
    if @current_x < @next_x && @current_y == @next_y && right_direction? then
        puts "ｘが増えたよ" 
        turn_right
    elsif @current_x < @next_x && @current_y == @next_y && left_direction? then
        puts "ｘが増えたよ"
        turn_left
    elsif @current_x < @next_x && @current_y == @next_y && forward_direction? then
        puts "ｘが増えたよ"
        forward 
    elsif @current_x < @next_x && @current_y == @next_y && back_direction?
        puts "ｘが増えたよ"
        back
    #ｙだけ増加
    elsif @current_x == @next_x && @current_y < @next_y && right_direction? then
        puts "yが増えたよ"
        turn_right
    elsif @current_x == @next_x && @current_y < @next_y && left_direction? then
        puts "yが増えたよ"
        turn_left
    elsif @current_x == @next_x && @current_y < @next_y && forward_direction? then
        puts "yが増えたよ"
        forward 
    elsif @current_x == @next_x && @current_y < @next_y && back_direction?
        puts "yが増えたよ"
        back 
    #ｘとｙが増加
    elsif @current_x < @next_x && @current_y < @next_y && right_direction? then
        puts "xyが増えたよ"
        turn_right
    elsif @current_x < @next_x && @current_y < @next_y && left_direction? then
        puts "xyが増えたよ"
        turn_left
    elsif @current_x < @next_x && @current_y < @next_y && forward_direction? then
        puts "xyが増えたよ"
        forward 
    elsif @current_x < @next_x && @current_y < @next_y && back_direction?
        puts "xyが増えたよ"
        back 
    #ｘだけ減少
    elsif @current_x > @next_x && @current_y == @next_y && right_direction? then
        puts "xが減ったよ"
        turn_right
    elsif @current_x > @next_x && @current_y == @next_y && left_direction? then
        puts "xが減ったよ"
        turn_left
    elsif @current_x > @next_x && @current_y == @next_y && forward_direction? then
        puts "xが減ったよ"
        forward 
    elsif @current_x > @next_x && @current_y == @next_y && back_direction?
        puts "xが減ったよ"
        back 
    #ｙだけ減少
    elsif @current_x == @next_x && @current_y > @next_y && right_direction? then
        puts "yが減ったよ"
        turn_right
    elsif @current_x == @next_x && @current_y > @next_y && left_direction? then
        puts "yが減ったよ"
        turn_left
    elsif @current_x == @next_x && @current_y > @next_y && forward_direction? then
        puts "yが減ったよ"
        forward 
    elsif @current_x == @next_x && @current_y > @next_y && back_direction?
        puts "yが減ったよ"
        back 
    #ｘとｙが減少
    elsif @current_x > @next_x && @current_y > @next_y && right_direction? then
        puts "xyが減ったよ"
        turn_right
    elsif @current_x > @next_x && @current_y > @next_y && left_direction? then
        puts "xyが減ったよ"
        turn_left
    elsif @current_x > @next_x && @current_y > @next_y && forward_direction? then
        puts "xyが減ったよ"
        forward 
    elsif @current_x > @next_x && @current_y > @next_y && back_direction?
        puts "xyが減ったよ"
        back 


    end
  end   

  def x_direction? #ｘの価が増えている
    @current_x < @next_x 
  end

  def right_direction? #右を向いている
    @direction == 1
  end
    def left_direction? #左を向いている
    @direction == 3
  end

  def forward_direction? #上を向いている
    @direction == 0
  end

  def back_direction? #下を向いている
    @direction == 2
  end

  def turn_right
    puts "turn_right"
    turn_right2(speed=WHEEL_SPEED)
    @direction = @direction + 1
  end

  def turn_left
    puts "turn_left"
    @direction = @direction - 1
  end

  def forward
    puts "forward"
    @direction = @direction + 2
  end

  def back
    puts "back"
    @direction = @direction
  end

end
player = PlayerTest2.new(1,0,0,[[0,0],[1,0],[2,0],[2,1],[2,2],[1,2],[1,3],[0,3],[0,2]])

8.times do 
  player.next
end
