# encoding: UTF-8
require './studentin.rb'
require './course.rb'
require './studiengang.rb'

subjects = []

subjects << anglistik = Studiengang.new("Anglistik", "FB2")
subjects << germanistik = Studiengang.new("Germanistik", "FB8")

courses = []

courses << kurs1 = Course.new("asdf", "jaifw", germanistik)
courses << kurs2 = Course.new("Schönschreiben", "Schreiben wie ein junger Gott!", anglistik)
courses << kurs3 = Course.new("Malen nach Zahlen", "In Windeseile zum neuen Van Gogh!", anglistik)

students = []

students << susi = Studentin.new("Müller", "Susanne", anglistik, 123456 )
students << lulu = Studentin.new("Müller", "Lulu", anglistik, 9482892 )
students << mimi = Studentin.new("Müller", "Mimi", germanistik, 123116 )
students << lili = Studentin.new("Müller", "Lili", anglistik, 1234564 )
students << anna = Studentin.new("Müller", "Anna", anglistik, 1243456 )
students << emma = Studentin.new("Müller", "Emma", anglistik, 1123456 )
students << helga = Studentin.new("Müller", "Helga", anglistik, 1123456 )

students.each do |s|
  puts s
end


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

while true

  puts "What Studentin are you looking for?"

  studentin = gets.chomp
  students.each do |s|
    if s.vorname == studentin
      @studentin = s
      puts "I know her!" 
    # else
    #   puts "I have no idea who that is." --> has to go in again!
    # end
    end
  end

  puts "Do you want #{studentin} to join a course (please type in A) or to leave a course (please type in B)?"

  purpose = gets.chomp
  if purpose == "A"
    purpose = "studentin.join_course"
  elsif purpose == "B"
    purpose = "studentin.leave_course"
  else
    puts "This option is unknown to me"
  end

  puts "Please enter the title of the course."

  course_title = gets.chomp

  courses.each do |c|
    @course = c if course_title == c.title
  end

  if purpose == "studentin.join_course"
   @studentin.join_course(@course)                                                        
  elsif purpose == "studentin.leave_course"
    @studentin.leave_course(@course)
  else 
    puts "Don't know what's going on"
  end

end

    
  



