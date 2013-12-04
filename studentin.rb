# encoding: UTF-8
require './studiengang.rb'
require './course.rb'


class Studentin
  
  attr_reader :courses

  def initialize(name, vorname, fach, matrikelnummer)
    @name = name
    @vorname = vorname
    @studiengang = fach
    @matrikelnummer = matrikelnummer
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






