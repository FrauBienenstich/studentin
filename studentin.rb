# encoding: UTF-8
require './studiengang.rb'
require './course.rb'


class Studentin
  def initialize(name, vorname, fach, matrikelnummer, kurs)
  
  attr_reader :courses
    @name = name
    @vorname = vorname
    @studiengang = fach
    puts @studiengang.inspect
    @matrikelnummer = matrikelnummer
    @kurs = kurs
  end
 
  def to_s
    "Name: " + @name + ", Vorname: " + @vorname + ", Studiengang: " + @studiengang.to_s + ", Matrikelnummer:" + @matrikelnummer.to_s + ", Kurs:" + @kurs.to_s
  end
 
  def wechseln!
    @studiengang = "EM02"
  end
 
  def drucke_wechsel
    @vorname + " " + @name + " studiert jetzt " + @neues_fach
 
  end
end






