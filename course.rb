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
    @studentinnen.each do |s|
      if s.vorname == studentin.vorname
        raise Exception.new("\n#{studentin.vorname} #{studentin.name} nimmt bereits an #{self.title} teil.\n")
      end
    end
    #does that work?


    if @studentinnen.length < 2 
      @studentinnen << studentin
      puts "\n#{studentin.name}, #{studentin.vorname} belegt jetzt #{self.title}\n"
    else
      raise Exception.new("\n#{self.title} ist voll, tut uns leid Frau #{studentin.name}.\n")
    end

  end

  def lose(studentin)
    puts "now losing #{studentin.vorname} #{@studentinnen.length}"
    if @studentinnen.include?(studentin)
      @studentinnen.delete(studentin)
      puts "#{studentin.vorname} #{studentin.name} hat den Kurs #{self.title} verlassen."
    else
      puts "You can't leave a course that you are not participating in! You are currently in the following courses: #{studentin.courses}"
    end
  end

end