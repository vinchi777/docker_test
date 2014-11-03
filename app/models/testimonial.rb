class Testimonial
  PATH = 'testimonials/'
  EXT = '.jpg'

  attr_accessor :student, :title, :quote, :image

  def initialize(student, title, quote)
    @student = student
    @title = title
    @quote = quote
    @image = "#{PATH}#{student.split(' ').last.downcase}#{EXT}"
  end

  def self.seed
    [
        Testimonial.new('Justine Joice Pastelero', 'Registered Nurse', 'Who says preparing for the board exam is back-breaking? It never was with MaxRevOne. My skills were greatly enhanced by 100% board-sensitive questions brought by excellent and brilliant national NLE lecturers. My special thanks to the selfless owners and staffs who supported us get through the test. Thanks MaxRevOne! We nailed it!'),
        Testimonial.new('Denise Agaton', 'Registered Nurse', "There were bunch of review centers who frantically advertised how good their review centers are but there wasn't any whom I can trust my future with. Everything changed when I passed by MaxRevOne. Fate turns you to a direction that you never saw yourself going but turns out to be the best road you've ever taken. Not only did I have the best mentors but I also got friends who are worth to keep. I never got second thoughts and regrets when I enrolled at MaxRevOne."),
        Testimonial.new('Arabel Beatrix Ticao', 'Registered Nurse', "Choosing MaxRevOne was a great decision. Their review assistants are registered nurses who are all approachable and kind. On my first visit, they already gave some pointers to read in advance. They did a thorough reasearch on lecturers in order to give us the best line up of reviewers. God has always been the center in everything they do. I'm proud to be a product of MaxRevOne and will always be grateful to them."),
    ].sort_by {|t| t.student}
  end
end