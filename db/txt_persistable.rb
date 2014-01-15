module Persistable
   
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
      puts "READ".pink
      list = []
      file_name = "#{database_name}.txt"
      return list unless File.exists? file_name
      database = File.open(file_name, "r")
      database.each do |line|
        fields = line.chomp.split(",")
        fields = fields.map {|f| f.chomp}
        puts fields.inspect
        list << class_to_create.new(*fields)
      end
      database.close
      list
    end

    def write(list)
      puts "WRITE".pink
      database = File.open("#{database_name}.txt", "w")
      puts "---"
  
      list.each do |thing_to_save|
        #puts thing_to_save.inspect
        database.puts(thing_to_save.get_values_to_save.join(","))
      end
      puts "---"
      database.close
    end
  end
end