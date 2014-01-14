# encoding: UTF-8

require './my_string.rb'
require './studentin.rb'

describe DbPersistable do
  describe "write" do
    it "saves the given list to the database" do
      studentin = Studentin.new("Lulu", "Knüller", "Sport", 9482892 )
      liste = [studentin]

      Studentin.write(liste,"studierendenverwaltung_test")

      list_to_read = Studentin.read("studierendenverwaltung_test")
      list_to_read.length.should == 1
      list_to_read[0].should == studentin

    end
  end

  
end