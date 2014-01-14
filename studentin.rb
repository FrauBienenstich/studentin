# encoding: UTF-8
require './studiengang.rb'
require './db_persistable.rb'
#require './db_persistable_courses.rb'
require './course.rb'

class Studentin  
  attr_reader :courses, :last_name, :first_name, :matrikelnummer
  attr_accessor :studiengang, :id

  include DbPersistable


  def get_values_to_save
    [@id, @first_name, @last_name, @studiengang, @matrikelnummer]
  end

  # def sql_queries#??
  #   begin
  #     con = Mysql.new 'localhost', 'root', ''

  #     all_dbs = con.list_dbs
  #     all_dbs.each do |db|
  #       puts db
  #     end
  #     puts "-----"

  #     con.query("use studierendenverwaltung;")
  #     result = con.query("show tables;")
  #     puts "#{result.num_rows} tables in the db."
  #     result.num_rows.times do
  #       puts result.fetch_row.join("\s")
  #     end

  #     con.query("")
  #       #Inhalt aus Textfile!?)
        
  #   rescue Mysql::Error => e
  #     puts e.errno
  #     puts e.error

  #   ensure
  #     con.close if con
  #   end
  # end

  def initialize(id, first_name, last_name, fach, matrikelnummer)
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

end