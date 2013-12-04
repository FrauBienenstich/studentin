# encoding: UTF-8
require './studentin.rb'

class Course
  attr_reader :studentinnen

  def initialize(title, description, studiengang)
    @title = title
    @description = description
    @studiengang = studiengang
  end

  def to_s
    "#{@title} (Kursbeschreibung: #{@description}), Studiengang: #{@studiengang}"
  end

  def enlist(studentin)
    @studentinnen ||= []
    @studentinnen << studentin
  end

  def drop_out(studentin)
    @studentinnen.delete(studentin)
  end

  def free
    if @studentinnen <= 5
      # 
    else
      #
    end
  end

end

#kurs ist voll bei 5 studentin
#studentinnen können sich nicht mehr einschreiben, wenn mehr als 5
#methode schreiben, die überprüft ob frei