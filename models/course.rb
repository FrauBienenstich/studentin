# encoding: UTF-8
require_relative 'studentin'
require_relative '../db/db_persistable.rb'

class Course
  attr_reader :studentinnen
  attr_reader :title

  include DbPersistable


  def get_values_to_save
    [@title, @description, @studiengang]
  end

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
      if s.first_name == studentin.first_name

        raise Exception.new("#{studentin.first_name} #{studentin.last_name} nimmt bereits an #{self.title} teil.".red)

      end
    end


    if @studentinnen.length < 2 
      @studentinnen << studentin
      puts
      puts "#{studentin.last_name}, #{studentin.first_name} belegt jetzt #{self.title}".yellow
      puts
    else
      puts @studentinnen
      raise Exception.new("#{self.title} ist voll, tut uns leid Frau #{studentin.last_name}.".red)

    end

  end

  def lose(studentin)

    if @studentinnen.include?(studentin)

      @studentinnen.delete(studentin)

      puts "#{studentin.first_name} #{studentin.last_name} hat den Kurs #{self.title} verlassen.".yellow
    else
      puts "You can't leave a course that you are not participating in! You are currently in the following courses: #{studentin.courses}".red
    end
  end

end