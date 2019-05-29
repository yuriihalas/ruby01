# frozen_string_literal: true
load 'doors.rb'
load 'control_panel.rb'

class Elevator
  WEIGHT_FOR_STRONG_ENGINE = 110
  ENGINE_STRONG = 2
  ENGINE = 1

  include Doors

  attr_accessor :total_weight, :speed, :engine, :control_panel

  def initialize
    self.control_panel = ControlPanel.new
    self.total_weight = 0
  end

  def run(weight_human)
    puts "It was on floor: #{control_panel.current_floor}"
    if control_panel.is_defined_way
      choose_engine
      move_elevator
      if control_panel.definition.include? control_panel.current_floor
        remove_person(weight_human)
      end
    else
      control_panel.wait
      return false
    end
    puts "Engine: #{engine}"
    puts "Total weight: #{total_weight}"
    control_panel.print_info
    true
  end

  def add_person(weight_human)
    open_door
    self.total_weight += weight_human
    control_panel.add_definition Random.rand(1..10)
    close_door
  end

  def remove_person(weight_human)
    open_door
    count_removed = control_panel.remove_definitions
    self.total_weight -= count_removed * weight_human
    close_door
  end

  private

  def move_elevator
    if control_panel.is_way_up
      puts 'move_up'
      control_panel.move_up
    else
      puts 'move_down'
      control_panel.move_down
    end
  end

  def choose_engine
    self.engine = if total_weight <= WEIGHT_FOR_STRONG_ENGINE
                    ENGINE
                  else
                    ENGINE_STRONG
                  end
  end
end
