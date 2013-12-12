# encoding: UTF-8
require './studentin.rb'
require './course.rb'
require './studiengang.rb'
require './my_string.rb'


subjects = []

subjects << anglistik = Studiengang.new("Anglistik", "FB2")
subjects << germanistik = Studiengang.new("Germanistik", "FB8")

@courses = []

@courses << kurs1 = Course.new("asdf", "jaifw", germanistik)
@courses << kurs2 = Course.new("Schönschreiben", "Schreiben wie ein junger Gott!", anglistik)
@courses << kurs3 = Course.new("Malen nach Zahlen", "In Windeseile zum neuen Van Gogh!", anglistik)

system('clear')

@students = Studentin.read || []

# if students doeas not exist, create bogus data
if @students.length == 0
  @students << susi = Studentin.new("Müller", "Susanne", anglistik, 123456 )
  @students << lulu = Studentin.new("Knüller", "Lulu", anglistik, 9482892 )
  @students << mimi = Studentin.new("Schnüller", "Mimi", germanistik, 123116 )
  @students << lili = Studentin.new("Füller", "Lili", anglistik, 1234564 )
  @students << anna = Studentin.new("Büller", "Anna", anglistik, 1243456 )
  @students << emma = Studentin.new("Züller", "Emma", anglistik, 1123456 )
  @students << helga = Studentin.new("Rüller", "Helga", anglistik, 1123456 )
  
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


@students.each do |s|
  puts s
end


@studentin = nil
@purpose = nil
@course = nil
@wants_to_exit = false

def ask
  input = gets.chomp
  if input.downcase == "exit"
    raise "ApplicationWantsToExit"
  end
  return input
end

def ask_for_studentin
  puts "What Studentin are you looking for?".yellow
  @studentin = ask #--> fragt nach Studentin und speihert sie in @studentin
  @students.each do |s|
    if s.vorname == @studentin
      puts @studentin = s # studentin objekt
    end #@studentin nicht nil, falls es angegebene Studentin gibt!, @studentin is eine Studentininstanz
  end

  if @studentin 
    puts "I know her!".yellow
  else
    @errors << "Did not find student".red
  end
  #@studentin.print_courses
end

def ask_for_purpose
  puts "Do you want #{@studentin.vorname} to join a course (please type in A) or to leave a course (please type in B)?".yellow
  purpose = ask

  if purpose == "A"
    @purpose = "studentin.join_course"
  elsif purpose == "B"
    @purpose = "studentin.leave_course"
  end

  if @purpose == "studentin.join_course"
    puts "You chose join as action".yellow
  elsif @purpose == "studentin.leave_course"
    puts "You chose leave as action.".yellow
  end

  unless @purpose
    @errors << "Don't know what to do!".red
  end     
end

def ask_for_course
  puts "Please enter the title of the course.".yellow
  course_title = ask

  @courses.each do |c|
    @course = c if course_title == c.title
  end

  unless @course
    @errors << "That's not a course I know!".red
  end     
end

def display_errors
  puts @errors.join
end

while not @wants_to_exit
  begin
    @errors = []
    puts "Here is a list of all the students:".yellow
    
    format = '%-7s %-15s %-13s %-10s %-15s'
    puts format % ['Number', 'Name', 'Studiengang', 'Matrikelnr.', 'Courses']
    @students.each_with_index do |member, i|
      puts format % [ i+1, member.vorname + " " + member.name, member.studiengang, member.matrikelnummer, member.all_course_names]
      #puts format % [ i+1, member.vorname + " " + member.name, member.studiengang.name, member.matrikelnummer, member.all_course_names]
      #member.studiengang.name
    end


    unless @studentin
      ask_for_studentin
    end

    if @studentin and not @purpose
      ask_for_purpose
    end

    if @studentin and @purpose and not @course
      ask_for_course
    end

    if @errors.length > 0
      display_errors # wann aufgerufen?
    else
      if @purpose == "studentin.join_course"
        @studentin.join_course(@course)
      elsif @purpose == "studentin.leave_course"
        @studentin.leave_course(@course)
      end
      @studentin = nil
      @purpose = nil
      @course = nil
    end

    # sleep 5
    # system('clear')
  rescue
    @wants_to_exit = true
  end
end

Studentin.write(@students)



