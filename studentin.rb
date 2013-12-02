class Studentin
  def initialize(n, v, f, m)
    @name = n
    @vorname = v
    @studiengang = f
    @matrikelnummer = m
  end
 
  def to_string
    puts "Name: " + @name + ", Vorname: " + @vorname + ", Studiengang: " + @studiengang + ", Matrikelnummer:" + @matrikelnummer.to_s
  end
 
  def wechseln
    puts "In welches Fach ist die Studentin gewechselt? "
    @neues_fach = "EM02"
  end
 
  def drucke_wechsel
    puts @vorname + " " + @name + " studiert jetzt " + @neues_fach
 
  end
 
end
 
susi = Studentin.new("Müller", "Susanne", "Maschinenbau", 123456 )
 
puts susi.to_string
puts susi.wechseln
puts susi.drucke_wechsel