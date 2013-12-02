# encoding: UTF-8
class Studentin
  def initialize(n, v, f, m, k)
    @name = n
    @vorname = v
    @studiengang = f
    @matrikelnummer = m
    @kurs = k
  end
 
  def to_string
    "Name: " + @name + ", Vorname: " + @vorname + ", Studiengang: " + @studiengang + ", Matrikelnummer:" + @matrikelnummer.to_s + ", Kurs:" + @kurs.to_s
  end
 
  def wechseln!
    @studiengang = "EM02"
  end
 
  def drucke_wechsel
    @vorname + " " + @name + " studiert jetzt " + @neues_fach
 
  end
 
end
 
susi = Studentin.new("Müller", "Susanne", "Maschinenbau", 123456, "Geschichte" )
 
# puts susi.to_string
# susi.wechseln!
# puts susi.to_string

class Studiengang

  def initialize(name, fachbereich)
    @name = name
    @fachbereich = fachbereich
  end

  def to_string
    @name + " (Fachbereich: " + @fachbereich + ")"
  end

end

germanistik = Studiengang.new("Germanistik", "FB1")
anglistik = Studiengang.new("Anglistik", "FB2").to_string


# uschi = Studentin.new("Maier", "Uschi", anglistik, 123456).to_string

# puts uschi


class Course
  @courses = []
  @count = 0
  def initialize(title, description)
    @title = title
    @description = description
    Course.add
    Course.push
    #@courses 
  end

  def self.push
    @courses << self
  end

  def self.all
    @courses
  end

  def self.add
    @count += 1
  end

  def self.count
    @count
  end

  def self.check_amount
    if self.count > 5 
      puts "Enuff!" 
    else
      puts "need moar!"
    end
  end

  def to_string

    " " + @title + "(Kursbeschreibung: " + @description + ")"
  end

end

kurs1 = Course.new("asdf", "jaifw")
kurs2 = Course.new("Schönschreiben", "Schreiben wie ein junger Gott!")
kurs3 = Course.new("Malen nach Zahlen", "In Windeseile zum neuen Van Gogh!")
#kurs4 = Course.new("Seepferdchen", "Für Anfänger und Fortgeschrittene")
kurs5 = Course.new("Quantum mechanics", "It deals with physical phenomena at microscopic 
            scales, where the action is on the order of the Planck constant.")
kurs6 = Course.new("Time Travel", "What is life like in the future?")

puts Course.count
puts Course.all

kurs6 = kurs6.to_string
uschi = Studentin.new("Maier", "Uschi", anglistik, 123456, kurs6).to_string
puts uschi

Course.check_amount





