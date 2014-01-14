# encoding: UTF-8

require './my_string.rb'
require './studentin.rb'
require 'awesome_print'

describe DbPersistable do

  

  def should_be_similar(a, b)
    a.instance_variables.each do |prop|
      puts prop.inspect
      if a.instance_variable_get(prop) != b.instance_variable_get(prop)
        return false
      end
      return true
    end
  end

  def should_be_similar_2(a, b)
    ap a.methods
  end

  before(:each) do
    @studentin = Studentin.new("Lulu", "Knueller", "Sport", 9482892 )
    @liste = [@studentin]
    Studentin.clear_database
  end

  #after_do: drop table xy
  describe "write" do
    it "saves the given list to the database" do

      Studentin.write(@liste,"studierendenverwaltung_test")

      list_to_read = Studentin.read("studierendenverwaltung_test")
      list_to_read.length.should == 1

      # [:first_name, :last_name].each do |prop|
      #   list_to_read[0].send(prop).should == @studentin.send(prop)
      #   list_to_read[0]
      # end
      
      should_be_similar_2(list_to_read[0], @studentin)

    end
  end


  describe "clear_database" do
    it "clears the database after every test run" do

      Studentin.write(@liste,"studierendenverwaltung_test")

      result = Studentin.read("studierendenverwaltung_test")

      should_be_similar @liste, result
    end
  end
end