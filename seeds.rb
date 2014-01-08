# encoding: UTF-8
require './studentin.rb'
require './course.rb'
require './studiengang.rb'
require './my_string.rb'
require './university_management.rb'
require './db_persistable.rb'

subjects = []

subjects << anglistik = Studiengang.new("Anglistik", "FB2")
subjects << germanistik = Studiengang.new("Germanistik", "FB8")

@courses = []

@courses << kurs1 = Course.new("asdf", "jaifw", germanistik)
@courses << kurs2 = Course.new("Schönschreiben", "Schreiben wie ein junger Gott!", anglistik)
@courses << kurs3 = Course.new("Malen nach Zahlen", "In Windeseile zum neuen Van Gogh!", anglistik)

#system('clear')
# if students does not exist, create bogus data
@students = []
if @students.length == 0
  @students << susi = Studentin.new("1", "Susanne",  "Müller", "Sport", 123456 )
  @students << lulu = Studentin.new("2", "Lulu", "Knüller", "Sport", 9482892 )
  @students << mimi = Studentin.new("3", "Mimi", "Schnüller", "Sport", 123116 )
  @students << lili = Studentin.new("4", "Lili", "Füller", "Sport", 1234564 )
  @students << anna = Studentin.new("5", "Anna", "Büller", "Sport", 1243456 )
  @students << emma = Studentin.new("6", "Emma", "Züller", "Sport", 1123456 )
  @students << helga = Studentin.new("7", "Helga", "Rüller", "Sport", 1123456 )
  
  susi.join_course(kurs1)
  lulu.join_course(kurs1)
  mimi.join_course(kurs1)
  lili.join_course(kurs1)
  anna.join_course(kurs1)
  emma.join_course(kurs1)
  helga.join_course(kurs1)

  helga.leave_course(kurs1)



  #susi.wechseln!(germanistik)
end