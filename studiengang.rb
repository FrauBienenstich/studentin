# encoding: UTF-8
class Studiengang

  def initialize(name, fachbereich)
    @name = name
    @fachbereich = fachbereich
  end

  def to_string
    @name + " (Fachbereich: " + @fachbereich + ")"
  end

end