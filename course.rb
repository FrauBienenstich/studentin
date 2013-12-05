# encoding: UTF-8
require './studentin.rb'

class Course
  attr_reader :studentinnen

  def initialize(title, description, studiengang)
    @title = title
    @description = description
    @studiengang = studiengang
    @studentinnen ||= []
    puts "Ein neuer Kurs im Studiengang " + studiengang.name + " wurde angelegt!"
  end

  def to_s
    "#{@title} (Kursbeschreibung: #{@description}), Studiengang: #{@studiengang}"
  end

  def gain(studentin)
    if @studentinnen.length < 5
      @studentinnen << studentin
    else
      raise "Course full"
    end
  end

  def lose(studentin)
    @studentinnen.delete(studentin)
  end

  # raise Exception.new("blabla")

end

#kurs ist voll bei 5 studentin
#studentinnen können sich nicht mehr einschreiben, wenn mehr als 5
#methode schreiben, die überprüft ob frei