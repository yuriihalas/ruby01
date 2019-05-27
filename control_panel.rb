# frozen_string_literal: true

module ControlPanel
  attr_accessor :current_floor, :definition

  def call_help
    puts 'Function is not defined'
  end

  def add_definition(definition)
    self.definition.push(definition)
  end

  def close_door
    puts 'Door close..'
  end

  def open_door
    puts 'Door open..'
  end

  def print_info
    puts "Definition: #{definition}\nNow current floor: #{current_floor}\n "
  end

  private

  def remove_definitions
    size_definition_before = definition.size
    size_definition_after = definition.delete_if {|x| x == current_floor}.length
    size_definition_before - size_definition_after
  end

  def move_up
    self.current_floor += 1
  end

  def move_down
    self.current_floor -= 1
  end

  def wait
    puts "Waiting for new person\nLift is empty"
  end

  # define if elevator should move up
  # @return [Boolean]
  def is_way_up
    current_floor < definition[0]
  end

  # @return [Boolean]
  def is_defined_way
    !definition.empty?
  end
end
