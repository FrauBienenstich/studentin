# encoding: UTF-8
require './studentin.rb'
require './course.rb'
require './studiengang.rb'

anglistik = Studiengang.new("Anglistik", "FB2")
germanistik = Studiengang.new("Germanistik", "FB8")

kurs1 = Course.new("asdf", "jaifw", germanistik)
kurs2 = Course.new("Schönschreiben", "Schreiben wie ein junger Gott!", anglistik)
kurs3 = Course.new("Malen nach Zahlen", "In Windeseile zum neuen Van Gogh!", anglistik)

students = []

students << susi = Studentin.new("Müller", "Susanne", anglistik, 123456 )
students << lulu = Studentin.new("Müller", "Lulu", anglistik, 9482892 )
students << mimi = Studentin.new("Müller", "Mimi", germanistik, 123116 )
students << lili = Studentin.new("Müller", "Lili", anglistik, 1234564 )
students << anna = Studentin.new("Müller", "Anna", anglistik, 1243456 )
students << emma = Studentin.new("Müller", "Emma", anglistik, 1123456 )


students.each do |s|
  puts s
end


# susi.join_course(kurs3)
# susi.join_course(kurs2)
# puts susi.courses
# puts "_________________"
# susi.leave_course(kurs2)
# puts susi.courses
# puts susi.check_amount_courses

# puts susi.leave_course(kurs2)
# puts kurs2.studentinnen.count
kurs1.gain(susi)
kurs1.gain(lulu)
kurs1.gain(lili)
kurs1.gain(mimi)
kurs1.gain(anna)
kurs1.gain(emma)


puts kurs1.studentinnen.length






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