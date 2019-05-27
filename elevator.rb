# frozen_string_literal: true
load 'control_panel.rb'

class Elevator
  include ControlPanel
  WEIGHT_FOR_STRONG_ENGINE = 110
  ENGINE_STRONG = 2
  ENGINE = 1

  attr_accessor :total_weight, :speed, :engine

  def initialize
    self.definition = []
    self.current_floor = 1
    self.total_weight = 0
  end


  def run(weight_human)
    puts "It was on floor: #{current_floor}"
    if is_defined_way
      choose_engine
      move_elevator
      remove_person(weight_human) if definition.include? current_floor
    else
      wait
      return false
    end
    puts "Engine: #{engine}"
    puts "Total weight: #{total_weight}"
    print_info
    true
  end

  def add_person(weight_human)
    open_door
    self.total_weight += weight_human
    add_definition Random.rand(1..10)
    close_door
  end

  def remove_person(weight_human)
    open_door
    count_removed = remove_definitions
    self.total_weight -= count_removed * weight_human
    close_door
  end

  private

  def move_elevator
    if is_way_up
      puts 'move_up'
      move_up
    else
      puts 'move_down'
      move_down
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
