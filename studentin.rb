# encoding: UTF-8
class Studentin
  def initialize(n, v, f, m)
    @name = n
    @vorname = v
    @studiengang = f
    @matrikelnummer = m
  end
 
  def to_string
    "Name: " + @name + ", Vorname: " + @vorname + ", Studiengang: " + @studiengang + ", Matrikelnummer:" + @matrikelnummer.to_s
  end
 
  def wechseln!
    @studiengang = "EM02"
  end
 
  def drucke_wechsel
    @vorname + " " + @name + " studiert jetzt " + @neues_fach
 
  end
 
end
 
susi = Studentin.new("Müller", "Susanne", "Maschinenbau", 123456 )
 
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


uschi = Studentin.new("Maier", "Uschi", anglistik, 123456).to_string

puts uschi





