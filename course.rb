# encoding: UTF-8
require './studentin.rb'

class Course
  attr_reader :studentinnen
  attr_reader :title

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
      puts "#{studentin.name}, #{studentin.vorname} belegt jetzt #{self.title}"
    else
      raise Exception.new("#{self.title} ist voll, tut uns leid Frau #{studentin.name}")
    end
  end

  def lose(studentin)
    @studentinnen.delete(studentin)
    puts "#{studentin.vorname} #{studentin.name} hat den Kurs #{self.title} verlassen."
  end


end

#kurs ist voll bei 5 studentin
#studentinnen können sich nicht mehr einschreiben, wenn mehr als 5
#methode schreiben, die überprüft ob frei