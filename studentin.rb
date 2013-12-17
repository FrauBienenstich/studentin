# encoding: UTF-8
require './studiengang.rb'
require './course.rb'


class Studentin
  
  attr_reader :courses, :last_name, :first_name, :matrikelnummer, :id
  attr_accessor :studiengang

  def initialize(id, last_name, first_name, fach, matrikelnummer)
    @id = id
    @last_name = last_name
    @first_name = first_name
    @studiengang = fach
    @matrikelnummer = matrikelnummer
    @courses ||= []
    #@full_name = @first_name + @last_name
  end

  def full_name
    "#{@first_name} #{@last_name}"
  end
 
  def to_s
    "'ID: #{@id}, Last Name: #{@last_name}, first_name: #{@first_name}, Studiengang: #{@studiengang}, Matrikelnummer: #{@matrikelnummer}'"
  end

  # def new_studentin
  #   Studentin.initialize

  #   if @students.length == 0
  # @students << susi = Studentin.new("1", "Müller", "Susanne", anglistik, 123456 )

  # end
 
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

  def self.read
    list = []
    database = File.open("database.txt", "r")
    database.each do |line|
      fields = line.chomp.split(",")
      list << Studentin.new(*fields)
    end
    list
  end

  def self.write(list)
    database = File.open("database.txt", "w")
    list.each do |studentin|
      course = studentin.courses.to_s
      formatted_course = course.delete!(",")
      database.puts( "#{studentin.id}" + "," + "#{studentin.last_name}" + "," + "#{studentin.first_name}" + "," + "#{studentin.studiengang}" + "," + "#{studentin.matrikelnummer.to_s}" )#+ "," + formatted_course )
    end
    database.close
  end

end