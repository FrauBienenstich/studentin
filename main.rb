# encoding: UTF-8
require './studentin.rb'
require './course.rb'
require './studiengang.rb'

anglistik = Studiengang.new("Anglistik", "FB2")

kurs1 = Course.new("asdf", "jaifw", "xyz")
kurs2 = Course.new("Schönschreiben", "Schreiben wie ein junger Gott!", anglistik)
kurs3 = Course.new("Malen nach Zahlen", "In Windeseile zum neuen Van Gogh!", "Kunst")

susi = Studentin.new("Müller", "Susanne", anglistik, 123456 )


susi.join_course(kurs3)
susi.join_course(kurs2)
puts susi.courses
puts "_________________"
susi.leave_course(kurs2)
puts susi.courses
puts susi.check_amount_courses

puts susi.leave_course(kurs2)
puts kurs2.studentinnen.count




# puts anglistik
# puts susi

# def belege(studentin, kurs)
# end

 
#  puts susi
#  puts susi.to_s
# # # susi.wechseln!
# # # puts susi.to_s



# germanistik = Studiengang.new("Germanistik", "FB1")

# array = ["hallo"]

# puts array.to_s

# class Animal
# end

# a = Animal.new
# puts a
# puts a.to_s




# kurs1 = Course.new("asdf", "jaifw")
# kurs2 = Course.new("Schönschreiben", "Schreiben wie ein junger Gott!")
# kurs3 = Course.new("Malen nach Zahlen", "In Windeseile zum neuen Van Gogh!")
# #kurs4 = Course.new("Seepferdchen", "Für Anfänger und Fortgeschrittene")
# kurs5 = Course.new("Quantum mechanics", "It deals with physical phenomena at microscopic 
#             scales, where the action is on the order of the Planck constant.")
# kurs6 = Course.new("Time Travel", "What is life like in the future?")

# puts Course.count
# puts Course.all.inspect

# kurs6 = kurs6.to_s
# uschi = Studentin.new("Maier", "Uschi", anglistik, 123456, kurs6).to_s #neue Instanz von Studentin ruft gesetzte Instanz
#                                                                             # von Course und Studiengang auf.
# puts uschi

# Course.check_amount