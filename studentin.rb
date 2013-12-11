# encoding: UTF-8
require './studiengang.rb'
require './course.rb'


class Studentin
  
  attr_reader :courses, :name, :vorname, :matrikelnummer
  attr_accessor :studiengang

  def initialize(name, vorname, fach, matrikelnummer)
    @name = name
    @vorname = vorname
    @studiengang = fach
    @matrikelnummer = matrikelnummer
    @courses ||= []
  end
 
  def to_s
    "Name: #{@name}, Vorname: #{@vorname}, Studiengang: #{@studiengang}, Matrikelnummer: #{@matrikelnummer}"
  end
 
  def wechseln!(studiengang)
    @studiengang = studiengang
    puts "#{self.vorname} #{self.name} hat in den Studiengang #{self.studiengang} gewechselt."
  end

  def join_course(course)
    puts "calling join_course #{course}"
    if course
      begin
        course.gain(self) 
        @courses << course
      rescue Exception => e
        puts e
      end
    else
      puts "This course does not exist!"
    end
  end

  def leave_course(course)
    puts "calling leave course with parameters #{course}"
    if course#!!!!!!! kein kurs, was wenn man B aufruft? vermeiden dass while loop
      @courses.delete(course) #deletes course from array
      course.lose(self) #simultaneously calls "drop_out" on course
    else

    end
  end

  def all_courses
    @courses 
  end

  def all_course_names
    @all_course_names = []
    all_courses.each do |a|
      @all_course_names << a.title
    end

    @all_course_names.to_s.gsub('"', '')
  end

  def print_courses
    if @courses.empty?
      puts "The student is currently not taking part in any courses."
    else
      puts "#{self.name} takes part in the following course: #{self.all_courses}."
    end
  end

  def check_amount_courses 
    if @courses.count > 5 
      puts "Enuff!" 
    else
      puts "need moar!"
    end
  end

end






