# encoding: UTF-8
class Studiengang

  attr_accessor :name
  
  def initialize(name, fachbereich)
    @name = name
    @fachbereich = fachbereich
  end

  def to_s
    "#{@name} (Fachbereich: #{@fachbereich})"
  end

end