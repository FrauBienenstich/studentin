class UniversityManagement

  def self.ask
    input = gets.chomp
    if input.downcase == "exit"
      raise "ApplicationWantsToExit"
    end
    return input
  end

  def self.select_studentin(students)
    puts "What Studentin are you looking for?".yellow
    vorname = self.ask
    studentin = nil
    students.each do |s|
      if s.first_name == vorname
        studentin = s
        puts "I know her!".yellow
      end 
    end

    unless studentin
      puts "NO STUDENT FOUND".red
    end

    return studentin
  end

  def self.ask_for_purpose
    puts "Do you want to create a new student (please type A)? Or do you you want join a new course (type B), leave a course (type C), or delete a student (type X)?".yellow
    purpose = self.ask

    if purpose == "A"
      puts "You want to create a new student!".yellow
    elsif purpose == "B"
      puts "You chose join as action".yellow
    elsif purpose == "C"
      puts "You want to leave a course".yellow
    elsif purpose == "X"
      puts "You want to delete a student".yellow
    end

    unless purpose
      @errors << "Don't know what to do!".red
    end
    purpose
  end

  def self.ask_for_course(courses)
    puts "Please enter the title of the course.".yellow
    course_title = self.ask

    course = nil # da lokale Variable: muss ausserhalb des Blocks bekanntgemacht werden
    courses.each do |c|
      course = c if course_title == c.title
    end

    unless course
      puts "I don't know this course!"
      #@errors << "That's not a course I know!".red
    end
    return course

  end

  def self.create_new_student(preexisting_students)
    puts "What's the first name?"
    new_first_name = self.ask

    puts "What's the last name?"
    new_last_name = self.ask

    puts "What's the student's subject."
    new_students_subject = self.ask

    puts "Please give me the student's Matrikelnummer."
    new_students_matrikelnummer = self.ask

    student_ids = Array.new
    preexisting_students.each do |s|
      student_ids << s.id.to_i
    end

    highest_id = student_ids.max


    new_id = self.find_unique_id(highest_id, preexisting_students) # höchste vergebene id


    new_studentin = Studentin.new(new_id, new_last_name, new_first_name, new_students_subject, new_students_matrikelnummer )

    puts "You successfully created Studentin #{new_first_name} #{new_last_name}!".pink
    
    if preexisting_students.find_index { |studentin| studentin.full_name == new_studentin.full_name} == nil
      return new_studentin
    else
      return nil
      puts "This student already exists"
    end
  end 

  def self.is_id_unique?(id, students)
    index_of_student_with_this_id = students.find_index { |studentin| studentin.id == id.to_s}
    if index_of_student_with_this_id == nil
      return true
    else
      return false
    end
  end

  def self.find_unique_id(id, students)
    if self.is_id_unique?(id, students)
      return id
    else
      self.find_unique_id(id + 1, students)
    end
  end

  def self.ask_for_new_student(students)
    puts "Do you want to add a new student to the list? Please answer with 'Y' or 'N'".yellow
    answer = self.ask

    if answer == "Y"
      return self.create_new_student(students)
    end
  end

  def self.display_errors
    puts @errors.join
  end

end