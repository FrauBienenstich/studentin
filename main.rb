# encoding: UTF-8

require './models/studentin.rb'
require './models/course.rb'
require './models/studiengang.rb'
require './helpers/my_string.rb'
require './helpers/university_management.rb'
require './db/db_persistable.rb'
require './db/seeds.rb'
require 'mysql'


@students = Studentin.read || []

@wants_to_exit = false
@do_not_write = false
while not @wants_to_exit 
  begin
    @errors = []
    puts "Here is a list of all the students:".yellow
    
    format = '%-7s %-15s %-13s %-10s %-15s'
    puts format % ['ID', 'Name', 'Studiengang', 'Matrikelnr.', 'Courses']
    @students.each_with_index do |member, i|
      puts format % [ member.id, member.first_name + " " + member.last_name, member.studiengang, member.matrikelnummer, member.all_course_names]
    end

    purpose = UniversityManagement.ask_for_purpose

    if @errors.length > 0 #TODO change order of if and else, always positive first
      display_errors # wann aufgerufen?
    else


      case purpose
      when "A"
        studentin = UniversityManagement.create_new_student(@students)
        @students << studentin
      when "B"
        studentin = UniversityManagement.select_studentin(@students)
        unless studentin == nil
          course = UniversityManagement.ask_for_course(@courses)
          studentin.join_course(course)
        end
      when "C"
        studentin = UniversityManagement.select_studentin(@students)
        unless studentin == nil
          course = UniversityManagement.ask_for_course(@courses)
          studentin.leave_course(course)
        end
        when "X"
          studentin = UniversityManagement.select_studentin(@students)
          unless studentin == nil
            @students.delete(studentin)
            studentin.delete
            puts "You just deleted #{studentin}."
          end
        end

      purpose = nil
      course = nil
    end

  rescue SystemExit, Interrupt
    @wants_to_exit = true
    @do_not_write = true
  rescue Exception => e
    puts e.to_s
    @wants_to_exit = true
  end
end
puts "DA LIST"
puts @students
Studentin.write(@students) unless @do_not_write