# encoding: UTF-8
require_relative 'studiengang'
require_relative '../db/db_persistable.rb'
#require './db_persistable_courses.rb'
require_relative 'course'

class Studentin  
  attr_reader :courses, :last_name, :first_name, :matrikelnummer
  attr_accessor :studiengang, :id

  include DbPersistable


  def get_values_to_save
    [@first_name, @last_name, @studiengang, @matrikelnummer]
  end

  def initialize(id = nil, first_name, last_name, fach, matrikelnummer)
    @id = id
    @first_name = first_name
    @last_name = last_name
    @studiengang = fach
    @matrikelnummer = matrikelnummer
    @courses = []
    #@full_name = @first_name + @last_name
  end

  def full_name
    "#{@first_name} #{@last_name}"
  end
 
  def to_s
    "'Last Name: #{@last_name}, first_name: #{@first_name}, Studiengang: #{@studiengang}, Matrikelnummer: #{@matrikelnummer}'"
  end
 
  def wechseln!(studiengang)
    @studiengang = studiengang
    puts "#{self.first_name} #{self.last_name} hat in den Studiengang #{self.studiengang} gewechselt."
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
    if course
      @courses.delete(course)
      course.lose(self)
    else

    end
  end

  def all_courses
    @courses 
  end

  def all_course_names
    all_course_names = []
    all_courses.each do |a|
      all_course_names << a.title
    end

    all_course_names.to_s.gsub('"', '')
  end

  def print_courses
    if @courses.empty?
      puts "The student is currently not taking part in any courses."
    else
      puts "#{self.last_name} takes part in the following course: #{self.all_courses}."
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