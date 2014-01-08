# encoding: UTF-8
require './studentin.rb'
require './course.rb'
require './studiengang.rb'
require './my_string.rb'
require './university_management.rb'
require './db_persistable.rb'

subjects = []

subjects << anglistik = Studiengang.new("Anglistik", "FB2")
subjects << germanistik = Studiengang.new("Germanistik", "FB8")

@courses = []

@courses << kurs1 = Course.new("asdf", "jaifw", germanistik)
@courses << kurs2 = Course.new("Schönschreiben", "Schreiben wie ein junger Gott!", anglistik)
@courses << kurs3 = Course.new("Malen nach Zahlen", "In Windeseile zum neuen Van Gogh!", anglistik)

#system('clear')

@students = Studentin.read || []

# if students does not exist, create bogus data
if @students.length == 0
  @students << susi = Studentin.new("1", "Müller", "Susanne", anglistik, 123456 )
  @students << lulu = Studentin.new("2", "Knüller", "Lulu", anglistik, 9482892 )
  @students << mimi = Studentin.new("3", "Schnüller", "Mimi", germanistik, 123116 )
  @students << lili = Studentin.new("4", "Füller", "Lili", anglistik, 1234564 )
  @students << anna = Studentin.new("5", "Büller", "Anna", anglistik, 1243456 )
  @students << emma = Studentin.new("6", "Züller", "Emma", anglistik, 1123456 )
  @students << helga = Studentin.new("7", "Rüller", "Helga", anglistik, 1123456 )
  
  susi.join_course(kurs1)
  lulu.join_course(kurs1)
  mimi.join_course(kurs1)
  lili.join_course(kurs1)
  anna.join_course(kurs1)
  emma.join_course(kurs1)
  helga.join_course(kurs1)

  helga.leave_course(kurs1)

  puts kurs1.studentinnen.length

  susi.wechseln!(germanistik)
end


# @students.each do |s|
#   puts s
# end

@wants_to_exit = false

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

    if @errors.length > 0
      display_errors # wann aufgerufen?
    else


      case purpose
      when "A"
        studentin = UniversityManagement.create_new_student(@students)
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
            puts "You just deleted #{studentin}."
          end
        end

    @students << studentin if purpose == "A"

      studentin = nil
      purpose = nil
      course = nil
    end

    # sleep 5
    # system('clear')
  rescue Exception => e
    puts e.to_s
    @wants_to_exit = true
  end
end

Studentin.write(@students)



