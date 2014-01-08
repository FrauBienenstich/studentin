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
        result = con.query("select * from studentinnen;")

        n_rows = result.num_rows

        entries = []
        n_rows.times do
          entries << result.fetch_row
        end
        puts entries.first.inspect

        students = []
        entries.each do |entry|
          students << class_to_create.new(*entry)
        end
        students

      rescue Mysql::Error => e
        puts e.errno
        puts e.error
      ensure
        con.close if con
      end  
    end


    def write(list)
      begin
        con = Mysql.new 'localhost', 'root', ''
        database = con.query("use studierendenverwaltung;")
        #insert list ie @students into studentin. BUT HOW?
        con.query("INSERT INTO studentinnen(last_name, first_name, studiengang, matrikelnummer) VALUES('Lovelace', 'Ada', 'Informatik', '942834234');")
        con.query("CREATE TABLE IF NOT EXISTS\
          Studentinnen(first_name VARCHAR(20), last_name VARCHAR(20), studiengang VARCHAR(20), matrikelnummer INT, id INT PRIMARY KEY AUTO_INCREMENT);")  
      
        #list.each do |student|





      rescue Mysql::Error => e
        puts e.errno
        puts e.error
      ensure
        con.close if con
      end
    end

  end



    # begin
    #   con = Mysql.new 'localhost', 'root', ''
    #   all_dbs = con.list_dbs
    #   all_dbs.each do |db|
    #     puts db
    #   end
    #   puts "_________________________"

    #   con.query("ALTER TABLE studentinnen DROP COLUMN id;")
    #   con.query("ALTER TABLE studentinnen ADD id INT PRIMARY KEY AUTO_INCREMENT;")

    #   con.query("CREATE TABLE IF NOT EXISTS\
    #     Studiengang(Id INT PRIMARY KEY AUTO_INCREMENT, Name VARCHAR(20), Fachbereich VARCHAR(20));")


    #   # result = con.query("show tables;")
    #   # puts "#{result.num_rows} tables in the db."
    #   # puts "_________________"
    #   # result.num_rows.times do
    #   #   puts result.fetch_row.join("\s")
    #   # end

    #   puts "-------------------------------------"

    #   #con.query("INSERT INTO studentinnen(last_name, first_name, studiengang, matrikelnummer) VALUES('Lovelace', 'Ada', 'Informatik', '942834234');")
    #   #con.query("DELETE FROM studentinnen WHERE last_name = 'Lovelace'")


    #   puts "-_-_-_-_-_"
    #   result.num_rows.times do
    #     puts result.fetch_row.join("\s")
    #   end

    #   puts "ID and Last Name where ID bigger than 25"
    #   query1 = con.query("SELECT id, last_name FROM studentinnen WHERE id > 15;")
    #   query1.num_rows.times do
    #     puts query1.fetch_row.join("\s")
    #   end 

    # rescue Mysql::Error => e
    #   puts e.errno
    #   puts e.error
    # ensure
    #   con.close if con
    # end
end