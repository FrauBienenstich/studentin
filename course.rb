# encoding: UTF-8
require 'studentin'

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

  def self.push # adds stuff to array
    @courses << self
  end

  def self.all # returns all elements of array
    @courses
  end

  def self.add # counts/adds up when new Course in initialized (is called in initialize method)
    @count += 1
  end

  def self.count # returns the count
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