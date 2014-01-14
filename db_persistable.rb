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
    Studentin.write([self]) # class method is called on instance
  end

  def persisted?
    id != nil
  end

  module ClassMethods

    def class_to_create
      @class_to_create
    end

    # class_to_create = base
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

    def read(database_name="studierendenverwaltung")
      puts "THE READ METHOD IS CALLED!!!!".pink
      
      begin
        con = establish_db_connection(database_name)
        result = con.query("select id, first_name, last_name, studiengang, matrikelnummer from studentinnen;")
        puts result

        n_rows = result.num_rows
        puts "NUMBERS"
        puts n_rows

        entries = []
        n_rows.times do
          entries << result.fetch_row
        end
        puts entries.first.inspect

        students = []
        entries.each do |entry|
          entry
          puts "THIS IS THE ENTRY"
          puts entry
          #spaltenamen last_name => entry[0]
          
          new_studentin = class_to_create.new(*database_row)#id rausfischen aber merken, die übrigen felder in new stecken
          new_studentin.id = gemerkteID
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


    def write(list, database_name="studierendenverwaltung")

      begin
        puts "_________________________________________________________" # wenn am ende gerufen als Klassenm. liste mit korrekter anzahl
        con = establish_db_connection(database_name)
        insert_statement = con.prepare "INSERT INTO studentinnen(first_name, last_name, studiengang, matrikelnummer) VALUES(?, ?, ?, ?);"
        update_statement = con.prepare("update studentinnen set first_name = ? where id = ? ;")

        list.each do |student|
          first_name = student.first_name
          last_name = student.last_name
          studiengang = student.studiengang
          matrikelnummer = student.matrikelnummer
          puts "Here is a student #{matrikelnummer}"
          if student.persisted?
            puts "the student IS persisted"
            update_statement.execute student.first_name, student.id
          else
            puts "student is not persisted"
            insert_statement.execute first_name, last_name, studiengang, matrikelnummer
            student.id = con.insert_id # I don't quite get why I need this!
            puts "con.insert_id value"
            puts con.insert_id
            puts "STUDENT ID:"
            puts student.id # returns different values than insert_id
          end
          puts "con.insert_id value!"
          puts con.insert_id # gibt immer 0 zurück!!!, sollte den letzten AUTO_INCREMENT value der Verbindung anzeigen...auto_increment nicht ausgeführt?
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