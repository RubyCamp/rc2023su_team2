LEFT_MOTOR = "C"
  RIGHT_MOTOR = "B"
  ARM_MOTOR = "B"
  CLAW_MOTOR = "C"
  DISTANCE_SENSOR = "4"
  PORT = "COM4"
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
  def turn_right(speed=WHEEL_SPEED)
    operate do
      @brick.reverse_polarity(RIGHT_MOTOR)
      @brick.start(speed, *wheel_motors)
    end
  end

  # 左に回る
  def turn_left(speed=WHEEL_SPEED)
    operate do
      @brick.reverse_polarity(LEFT_MOTOR)
      @brick.start(speed, *wheel_motors)
    end
  end