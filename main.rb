# encoding: UTF-8
require './studentin.rb'
require './course.rb'
require './studiengang.rb'


susi = Studentin.new("Müller", "Susanne", "Maschinenbau", 123456, "Geschichte" )
 
# puts susi.to_string
# susi.wechseln!
# puts susi.to_string



germanistik = Studiengang.new("Germanistik", "FB1")
anglistik = Studiengang.new("Anglistik", "FB2").to_string


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
uschi = Studentin.new("Maier", "Uschi", anglistik, 123456, kurs6).to_string #neue Instanz von Studentin ruft gesetzte Instanz
                                                                            # von Course und Studiengang auf.
puts uschi

Course.check_amount