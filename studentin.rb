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
    #"Name: " + @name + ", Vorname: " + @vorname + ", Studiengang: " + @studiengang.to_s + ", Matrikelnummer:" + @matrikelnummer.to_s
    "Name: #{@name}, Vorname: #{@vorname}, Studiengang: #{@studiengang}, Matrikelnummer: #{@matrikelnummer}"
  end
 
  def wechseln!
    @studiengang = "EM02"
  end
 
  def drucke_wechsel
    @vorname + " " + @name + " studiert jetzt " + @neues_fach
  end

  def join_course(course) # NB!!!!
    @courses ||= [] 
    @courses << course # adds course to @courses array
    course.enlist(self) #wischdischhh: calls on same course "enlist" 
  end

  def leave_course(course)
    @courses.delete(course) #deletes course from array
    course.drop_out(self) #simultaneously calls "drop_out" on course
  end

  def all_courses
    @courses 
  end

  def check_amount_courses 
    if @courses.count > 5 
      puts "Enuff!" 
    else
      puts "need moar!"
    end
  end

end






