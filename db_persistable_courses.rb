# require 'mysql'
# module DbPersistableCourses

#   def self.included(base)
#     base.extend(ClassMethods)
#     base.class_to_create = base
#     base.database_name = base.to_s.downcase

#     puts "included #{base.inspect} -> #{base.database_name}"
#   end

#   def get_values_to_save
#     ["foo"]
#   end

#   module ClassMethods

#       def class_to_create
#         @class_to_create
#       end

#       # class_to_create = base
#       def class_to_create=(base)
#         @class_to_create = base
#       end

#       def database_name
#         @database_name
#       end

#       def database_name=(name)
#         @database_name = name
#       end
     
#       def new_from_values(values)
#         nil
#       end

#     def read
      
#       begin
#         con = Mysql.new 'localhost', 'root', ''
#         database = con.query("use studierendenverwaltung;")

#         con.query("use studierendenverwaltung;")
#         con.query("show tables;")
#         result = con.query("select id, title, description, studiengang from courses;")

#         n_rows = result.num_rows
#         entries = []
#         n_rows.times do
#           entries << result.fetch_row
#         end

#         courses = []
#         entries.each do |entry|
#           courses << class_to_create.new(*entry)
#         end
#         courses

#       rescue Mysql::Error => e
#         puts e.error
#       ensure
#         con.close if con
#       end  
#     end


#     def write(list)
#       begin
#         con = Mysql.new 'localhost', 'root', ''
#         database = con.query("use studierendenverwaltung;")
#         con.query("CREATE TABLE IF NOT EXISTS\
#           courses(id INT PRIMARY KEY AUTO_INCREMENT, title VARCHAR(20), description VARCHAR(40), studiengang VARCHAR(20));")  
#         prepared_statement = con.prepare "INSERT INTO courses(title, description, studiengang) VALUES(?, ?, ?);"

#         list.each do |course|
#           title = course.title
#           description = course.description
#           studiengang = course.studiengang
#           prepared_statement.execute title, description, studiengang
#         end

#       rescue Mysql::Error => e
#         puts e.errno
#         puts e.error
#       ensure
#         con.close if con
#         prepared_statement.close if prepared_statement
#       end
#     end

#   end
# end