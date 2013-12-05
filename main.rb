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

kurs1.gain(susi)
kurs1.gain(lulu)
kurs1.gain(lili)
kurs1.gain(mimi)
kurs1.gain(anna)
kurs1.gain(emma)


puts kurs1.studentinnen.length
