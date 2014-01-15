require 'mysql'
module DbPersistable

  def self.included(base)
    base.extend(ClassMethods)
    base.class_to_create = base
    base.database_name = base.to_s.downcase

    puts "included #{base.inspect} -> #{base.database_name}"
  end

  def get_values_to_save
    ["foo"]
  end

  def write
    puts "THE INSTANCE METHOD WRITE IS CALLED".pink
    self.class.write([self]) # class method is called on instance
  end

  def delete
    self.class.delete(self)
  end


  def persisted?
    id != nil
  end

  module ClassMethods

    def class_to_create
      @class_to_create
    end

    def class_to_create=(base)
      @class_to_create = base
    end

    def database_name
      @database_name
    end

    def database_name=(name)
      @database_name = name
    end
   
    def new_from_values(values)
      nil
    end

    def clear_database
      con = Studentin.establish_db_connection("studierendenverwaltung_test")
      con.query("TRUNCATE table studentinnen;")
    end

    def read(database_name="studierendenverwaltung")
      puts "THE READ METHOD IS CALLED!!!!".pink
      
      begin
        con = establish_db_connection(database_name)
        result = con.query("select id, first_name, last_name, studiengang, matrikelnummer from studentinnen;")
        n_rows = result.num_rows

        entries = []

        n_rows.times do
          entries << result.fetch_row
        end
        puts entries.first.inspect

        students = []
        entries.each do |database_row|
          database_row
          new_studentin = class_to_create.new(*database_row)
          students << new_studentin
        end

        students

      rescue Mysql::Error => e
        puts e.error
      ensure
        con.close if con
      end  
    end

    def establish_db_connection(database_name)

      con = Mysql.new 'localhost', 'root', ''
      con.query("use #{database_name};")
      con.query("CREATE TABLE IF NOT EXISTS\
          studentinnen(id INT PRIMARY KEY AUTO_INCREMENT, first_name VARCHAR(20), last_name VARCHAR(20), studiengang VARCHAR(20), matrikelnummer INT, courses VARCHAR(20));")  
      con
    end

    def delete(student, database_name="studierendenverwaltung")
      con = establish_db_connection(database_name)
      delete_statement = con.prepare("DELETE FROM studentinnen WHERE id = ?")
      delete_statement.execute student.id

    end


    def write(list, database_name="studierendenverwaltung")

      begin
        puts "_________________________________________________________"
        con = establish_db_connection(database_name)
        insert_statement = con.prepare "INSERT INTO studentinnen(first_name, last_name, studiengang, matrikelnummer) VALUES(?, ?, ?, ?);"
        update_statement = con.prepare("update studentinnen set first_name = ? where id = ? ;")

        list.each do |student|
          first_name = student.first_name
          last_name = student.last_name
          studiengang = student.studiengang
          matrikelnummer = student.matrikelnummer
          if student.persisted?
            puts "UPDATING"
            update_statement.execute student.first_name, student.id
          else
            puts "INSERTING"
            insert_statement.execute first_name, last_name, studiengang, matrikelnummer
            student.id = con.insert_id # I don't quite get why I need this!
          end
        end

      rescue Mysql::Error => e
        puts e.errno
        puts e.error
      ensure
        con.close if con
        insert_statement.close if insert_statement
        update_statement.close if update_statement
      end
    end
  end

end