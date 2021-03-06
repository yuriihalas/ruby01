# frozen_string_literal: true

load 'elevator.rb'

class Application
  attr_accessor :elevator
  COUNT_PERSONS = 6
  WEIGHT_PERSON = 60

  def initialize
    self.elevator = Elevator.new
  end

  def run
    elevator.add_person(WEIGHT_PERSON)
    elevator.add_person(WEIGHT_PERSON)
    count_persons = 2

    while elevator.run WEIGHT_PERSON
      if count_persons <= COUNT_PERSONS
        add_person
        count_persons += 1
      end
    end
  end

  private

  def add_person
    elevator.add_person(WEIGHT_PERSON) if Random.new.rand(1..3) != 1
  end
end
