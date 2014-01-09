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
    Studentin.write([self])

    # begin
    #   puts "_________________________________________________________"
    #   con = Mysql.new 'localhost', 'root', ''
    #   database = con.query("use studierendenverwaltung;")
    #   con.query("CREATE TABLE IF NOT EXISTS\
    #     studentinnen(id INT PRIMARY KEY AUTO_INCREMENT, first_name VARCHAR(20), last_name VARCHAR(20), studiengang VARCHAR(20), matrikelnummer INT, courses VARCHAR(20));")  

    #   prepared_statement = con.prepare "INSERT INTO studentinnen(first_name, last_name, studiengang, matrikelnummer) VALUES(?, ?, ?, ?);"

    #     first_name = @first_name
    #     last_name = @last_name
    #     studiengang = @studiengang
    #     matrikelnummer = @matrikelnummer
    #     prepared_statement.execute first_name, last_name, studiengang, matrikelnummer

    # rescue Mysql::Error => e
    #   puts e.errno
    #   puts e.error
    # ensure
    #   con.close if con
    #   prepared_statement.close if prepared_statement
    # end
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

    def read
      
      begin
        con = Mysql.new 'localhost', 'root', ''
        database = con.query("use studierendenverwaltung;")

        con.query("use studierendenverwaltung;")
        con.query("show tables;")
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
          students << class_to_create.new(*entry)
        end
        students

      rescue Mysql::Error => e
        puts e.error
      ensure
        con.close if con
      end  
    end


    def write(list)
      begin
        puts "_________________________________________________________"
        con = Mysql.new 'localhost', 'root', ''
        database = con.query("use studierendenverwaltung;")
        con.query("CREATE TABLE IF NOT EXISTS\
          studentinnen(id INT PRIMARY KEY AUTO_INCREMENT, first_name VARCHAR(20), last_name VARCHAR(20), studiengang VARCHAR(20), matrikelnummer INT, courses VARCHAR(20));")  

        prepared_statement = con.prepare "INSERT INTO studentinnen(first_name, last_name, studiengang, matrikelnummer) VALUES(?, ?, ?, ?);"
        #update statemnt if id already exists
        list.each do |student|
          first_name = student.first_name
          last_name = student.last_name
          studiengang = student.studiengang
          matrikelnummer = student. matrikelnummer
          prepared_statement.execute first_name, last_name, studiengang, matrikelnummer
        end

      rescue Mysql::Error => e
        puts e.errno
        puts e.error
      ensure
        con.close if con
        prepared_statement.close if prepared_statement
      end
    end

  end
end