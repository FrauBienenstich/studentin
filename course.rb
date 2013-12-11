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

  # def import #read file
  #   database = File.open("database.txt", "r").each_line do |line|
  #     line.delete if line == studentin
  #   end
  # end

  def to_s
    "#{@title} (Kursbeschreibung: #{@description}), Studiengang: #{@studiengang}"
  end

  def gain(studentin)
    puts "calling gain #{studentin}"
    @studentinnen.each do |s|
      if s.vorname == studentin.vorname

        raise Exception.new("#{studentin.vorname} #{studentin.name} nimmt bereits an #{self.title} teil.".red)

      end
    end


    if @studentinnen.length < 2 
      @studentinnen << studentin
      puts
      puts "#{studentin.name}, #{studentin.vorname} belegt jetzt #{self.title}".yellow
      puts
    else

      raise Exception.new("#{self.title} ist voll, tut uns leid Frau #{studentin.name}.".red)

    end

  end

  def lose(studentin)
    puts "now losing #{studentin.vorname} #{@studentinnen.length}".yellow

    if @studentinnen.include?(studentin)

      @studentinnen.delete(studentin)

      puts "#{studentin.vorname} #{studentin.name} hat den Kurs #{self.title} verlassen.".yellow
    else
      puts "You can't leave a course that you are not participating in! You are currently in the following courses: #{studentin.courses}".red
    end
  end

end