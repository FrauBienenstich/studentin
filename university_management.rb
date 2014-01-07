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
    studentin = self.ask #--> fragt nach Studentin und speihert sie in @studentin
    puts "Choosing #{studentin}."
    puts students
    students.each do |s|
      if s.first_name == studentin # check
        studentin = s
        puts "Still choosing #{studentin}."
        puts "I know her!".yellow
        return studentin
      else
        #@errors << "Did not find student".red #what about @errors?
      end
    end
  end

  def self.ask_for_purpose
    puts "Is the purpose method called?"
    puts "Do you want to create a new student (please type A)? Or do you you want join a new course (type B), leave a course (type C), or delete a student (type X)?".yellow
    purpose = self.ask
    puts purpose

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
    puts course

    unless course
      @errors << "That's not a course I know!".red
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

    puts "These are the preexisting students:"
    puts preexisting_students

    student_ids = Array.new
    preexisting_students.each do |s|
      student_ids << s.id.to_i
    end

    puts "My student ids:"
    puts student_ids

    highest_id = student_ids.max

    puts "The highest ID:"
    puts highest_id

    new_id = self.find_unique_id(highest_id, preexisting_students) # höchste vergebene id

    puts "Any new IDs:"
    puts new_id

    new_studentin = Studentin.new(new_id, new_last_name, new_first_name, new_students_subject, new_students_matrikelnummer )
    puts "The new studentin!"
    puts new_studentin

    if preexisting_students.find_index { |studentin| studentin.full_name == new_studentin.full_name} == nil
      puts "Adding new student to students"
      #######
      return new_studentin# returns the new_studentin
    else
      return nil
      puts "This student already exists"
    end
  end 

  def self.is_id_unique?(id, students)
    puts "is_id_unique gets also called!"
    index_of_student_with_this_id = students.find_index { |studentin| studentin.id == id.to_s}
    puts "find_index method works?"
    if index_of_student_with_this_id == nil
      puts "index_of_student_with_this_id is nil"
      return true
    else
      puts "index_of_student_with_this_id is not nil"
      return false
      puts "it returns false"
    end
    puts "I dont understand"
  end

  def self.find_unique_id(id, students)
    puts "find_unique_id gets called!"
    if self.is_id_unique?(id, students)
      return id
      puts "the id is unique! OLE!"
    else
      puts "the id is not unique"
      self.find_unique_id(id + 1, students)
      puts "which is why its increased by one"
    end
  end

  def self.ask_for_new_student(students)
    puts "Do you want to add a new student to the list? Please answer with 'Y' or 'N'".yellow
    answer = self.ask

    if answer == "Y"
      puts self.create_new_student(students)
      return self.create_new_student(students)
    end
  end

  def self.display_errors
    puts @errors.join
  end

end