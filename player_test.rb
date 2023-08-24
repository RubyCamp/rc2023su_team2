class PlayerTest2
  COLOR_SENSOR = "2"
  DISTANCE_SENSOR = "3"
  LEFT_MOTOR = "C"
  RIGHT_MOTOR = "B"
  MOTOR_SPEED = 10

  attr_reader :last_color, :last_distance

  def initialize(port = "COM3")
    @motors = [LEFT_MOTOR, RIGHT_MOTOR]
    @brick = EV3::Brick.new(EV3::Connections::Bluetooth.new(port))
    @brick.connect
    @brick.reset(*@motors)
    @wait_cnt = 0
    @last_color = 0.0
    @last_distance = 0.0
    update_sensor_value
  end

  def move_forward(sec, speed = MOTOR_SPEED)
    @brick.start(speed, *@motors)
    sleep sec
    @brick.stop(true, *@motors)
  end

  def move_back(sec, speed = MOTOR_SPEED)
    @brick.reverse_polarity(*@motors)
    @brick.start(speed, *@motors)
    sleep sec
    @brick.stop(true, *@motors)
    @brick.reverse_polarity(*@motors)
  end

  def right_torun(sec, speed = MOTOR_SPEED)
    @brick.reverse_polarity(RIGHT_MOTOR)
    @brick.start(speed, *@motors)
    sleep sec
    @brick.stop(true, *@motors)
    @brick.run_forward(*@motors)

    @brick.start(speed, *@motors)
    sleep sec + 1
    @brick.stop(true, *@motors)
  end

  def left_torun(sec, speed = MOTOR_SPEED)
    @brick.reverse_polarity(LEFT_MOTOR)
    @brick.start(speed, *@motors)
    sleep sec
    @brick.stop(true, *@motors)
    @brick.run_forward(*@motors)

    @brick.start(speed, *@motors)
    sleep sec + 1
    @brick.stop(true, *@motors)
  end  

  def update_sensor_value
    @wait_cnt += 1
    return unless @wait_cnt % 30 == 0
    @last_color = @brick.get_sensor(COLOR_SENSOR, 2)
    @last_distance = @brick.get_sensor(DISTANCE_SENSOR, 0)
  end

  def close()
    @brick.stop(true, *@motors)
    @brick.clear_all
    @brick.disconnect
  end


end

right_torun(10,speed=MOTOR_SPEED)
