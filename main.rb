# encoding: UTF-8
require './studentin.rb'
require './course.rb'
require './studiengang.rb'
require './my_string.rb'
require 'mysql'

begin
  con = Mysql.new 'localhost', 'root', ''
  all_dbs = con.list_dbs
  all_dbs.each do |db|
    puts db
  end
  puts "_________________________"

  con.query("use studierendenverwaltung;")
  con.query("ALTER TABLE studentinnen DROP COLUMN id;")
  con.query("ALTER TABLE studentinnen ADD id INT PRIMARY KEY AUTO_INCREMENT;")

  con.query("CREATE TABLE IF NOT EXISTS\
    Studiengang(Id INT PRIMARY KEY AUTO_INCREMENT, Name VARCHAR(20), Fachbereich VARCHAR(20));")


  # result = con.query("show tables;")
  # puts "#{result.num_rows} tables in the db."
  # puts "_________________"
  # result.num_rows.times do
  #   puts result.fetch_row.join("\s")
  # end

  puts "-------------------------------------"

  #con.query("INSERT INTO studentinnen(last_name, first_name, studiengang, matrikelnummer) VALUES('Lovelace', 'Ada', 'Informatik', '942834234');")
  #con.query("DELETE FROM studentinnen WHERE last_name = 'Lovelace'")

  result = con.query("SELECT * FROM studentinnen;")

  puts "-_-_-_-_-_"
  result.num_rows.times do
    puts result.fetch_row.join("\s")
  end

  puts "ID and Last Name where ID bigger than 25"
  query1 = con.query("SELECT id, last_name FROM studentinnen WHERE id > 15;")
  query1.num_rows.times do
    puts query1.fetch_row.join("\s")
  end 

rescue Mysql::Error => e
  puts e.errno
  puts e.error
ensure
  con.close if con
end

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
    if s.first_name == @studentin
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

def ask_for_purpose(studentin)
  puts "Do you want #{@studentin.first_name} to join a course (please type in A) or to leave a course (please type in B)? You can also delete #{@studentin.first_name}, just type X.".yellow
  purpose = ask

  if purpose == "A"
    @purpose = "studentin.join_course"
  elsif purpose == "B"
    @purpose = "studentin.leave_course"
  elsif purpose == "X"
    @purpose = "studentin.delete"
  end

  if @purpose == "studentin.join_course"
    puts "You chose join as action".yellow
  elsif @purpose == "studentin.leave_course"
    puts "You chose leave as action.".yellow
  elsif @purpose == "studentin.delete"
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

def create_new_student
  puts "What's the first name?"
  new_first_name = ask

  puts "What's the last name?"
  new_last_name = ask

  puts "What's the student's subject."
  new_students_subject = ask

  puts "Please give me the student's Matrikelnummer."
  new_students_matrikelnummer = ask

  @student_ids = Array.new
  @students.each do |s|
    @student_ids << s.id.to_i
  end

  highest_id = @student_ids.max

  new_id = find_unique_id(highest_id) # höchste vergebene id

  new_studentin = Studentin.new(new_id, new_last_name, new_first_name, new_students_subject, new_students_matrikelnummer )

  if @students.find_index { |studentin| studentin.full_name == new_studentin.full_name} == nil
    @students << new_studentin
  else
    puts "This student already exists"
  end

end

def is_id_unique?(id)
  index_of_student_with_this_id = @students.find_index { |studentin| studentin.id == id.to_s}
  if index_of_student_with_this_id == nil
    return true
  else
    return false
  end
end

def find_unique_id(id)
  if is_id_unique?(id)
    return id

  else
    find_unique_id(id + 1)
  end
end


def ask_for_new_student
  puts "Do you want to add a new student to the list? Please answer with 'Y' or 'N'".yellow
  answer = ask

  if answer == "Y"
    create_new_student
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
    puts format % ['ID', 'Name', 'Studiengang', 'Matrikelnr.', 'Courses']
    @students.each_with_index do |member, i|
      puts format % [ member.id, member.first_name + " " + member.last_name, member.studiengang, member.matrikelnummer, member.all_course_names]
      #puts format % [ i+1, member.first_name + " " + member.name, member.studiengang.name, member.matrikelnummer, member.all_course_names]
      #member.studiengang.name
    end

    ask_for_new_student

    unless @studentin
      ask_for_studentin
    end

    if @studentin and not @purpose
      ask_for_purpose(@studentin)
    end

    if @studentin and @purpose and not @course
      ask_for_course unless @purpose == "studentin.delete"
    end

    if @errors.length > 0
      display_errors # wann aufgerufen?
    else
      if @purpose == "studentin.join_course"
        @studentin.join_course(@course)
      elsif @purpose == "studentin.leave_course"
        @studentin.leave_course(@course)
      elsif @purpose == "studentin.delete"
        @students.delete(@studentin)
        puts "You just deleted #{@studentin}."
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



