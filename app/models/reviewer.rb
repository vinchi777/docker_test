class Reviewer
  PATH = 'reviewers/faces/'
  EXT = '.jpg'

  attr_accessor :name, :title, :image

  def initialize(name, title)
    @name = name
    @title = title
    @image = "#{PATH}#{name.split(' ').last.downcase}#{EXT}"
  end

  def self.seed
    [
        Reviewer.new('Alvin Andrade','RN, MAN'),
        Reviewer.new('Christian Paul Biluan','RN, USRN, MAN'),
        Reviewer.new('Diana Mahinay','RN, MAN, phD'),
        Reviewer.new('Dindo De Guzman','DMD, RN, USRN, PhDBiochem'),
        Reviewer.new('Elenita Arreglo','RN, MD, MAN'),
        Reviewer.new('Ernest Jourdan Flaminiano','RN, MAN'),
        Reviewer.new('John Patrick Jacomille','RN, MAN'),
        Reviewer.new('Gilbert Marzan','RN, MAN'),
        Reviewer.new('Mark Billy Perpetua','RN, MAN'),
        Reviewer.new('Mary Anne Charry Te','RN, USRN, MAN'),
        Reviewer.new('Robert Joseph Seguin','RN, MAN'),
        Reviewer.new('Roland Villegas','RN, MAN, Review Center Owner'),
    ].sort_by { |f| f.name}
  end
end