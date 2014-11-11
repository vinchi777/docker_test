class Founder
  PATH = 'founders/'
  EXT = '.jpg'

  attr_accessor :name, :position, :background, :image

  def initialize(name, position, background)
    @name = name
    @position = position
    @background = background.strip
    @image = "#{PATH}#{name.split(' ').last.downcase}#{EXT}"
  end

  def self.seed
    puts "heheheh"
    [
        Founder.new(
            "Rommel D. Capungcol",
            "President",
            "Rommel graduated with a bachelor's degree in Nursing from the Remedios Trinidad Romualdez Medical Foundation in 1993. That same year, he took and passed the Nursing board examinations. Finding his thirst for knowledge unquenched, he pursued Medicine in the same year and graduated in 1997. Rommel joined the Eastern Visayas Regional Medical Center twice, as an intern in 1997-1998 and then as a resident-in-training in 1999-2002. He passed the medical board in 1998. In 2011, Rommel graduated from the Southwestern University with a master's degree in Public Administration. The following year, he graduated with a master's degree in Business Administration from the Asian Development Foundation College. At present, Rommel is a Medical Officer at the Philippine National Police - Regional Health Service, a Director at the Philippine National Red Cross - Leyte Chapter, and a student of Law at the Dr. Vicente Orestes Romualdez Educational Foundation."
        ),
        Founder.new(
            "Jose Van P. Tan",
            "Vice President and Treasurer",
            "Joe took up Nursing at Far Eastern University - Manila, where he graduated with a Bachelor of Science degree in April 2010. In the same year, he passed the Nurse Licensure Examination. After passing the examination, Joe co-founded SRG - Tacloban, the forerunner of Max Rev One. When he's not reviewing finances and overseeing the day-to-day operations of Max Rev One, Joe pursues his lifelong dream of becoming a lawyer at the Don Vicente Orestes Romualdez Educational Foundation (DVOREF), where he takes up Law."
        ),
        Founder.new(
            "Mariel C. Villaflor-Capungcol",
            "Owner",
            "Mariel is a Medical Technology graduate of the Divine Word University. She took and passed the Medical Technologist board examinations in 1989. In 2004, Mariel graduated with a bachelor's degree in Law from Dr. Vicente Orestes Romualdez Educational Foundation. She later studied at the Southwestern University, where she graduated with a master's degree in Public Administration in 2011. Today, Mariel is a faculty member of the College of Medical Technology at the Remedios Trinidad Romualdez Medical Foundation."
        ),
        Founder.new(
            "Christine Almedilla-Pablico",
            "Review Specialist and Head of Accounting",
            "Tin is a Nursing graduate of the Remedios Trinidad Romualdez Medical Foundation. After graduating in April 2007, another good fortune came her way: she passed the Nurse Licensure Examination in June of the same year. Tin worked at the Divine Word Hospital in Tacloban City for a while, but she later found a different calling after friends and family gently pushed her to leave her comfort zone. The calling turned out to be joining Max Rev One as a review specialist. Her most important guidepost in life is the saying, With God, everything is possible."
        ),
        Founder.new(
            "Cesar Czarbo P. Trani",
            "Review Specialist and Head of Marketing",
            "Czarbo is a graduate of St. Scholastica's College Tacloban, where he received his Bachelor of Science in Nursing degree. Prior to taking the Nurse Licensure Examination, Cesar worked part-time as a nurse researcher for Vantage Medical Review. His hard work soon paid off when he placed 12th in the July 2010 licensure examination with a general rating of 83.6 percent. In October 2010, he was hired as a staff of SRG - Tacloban, where he met his colleagues with whom he formed Max Rev One. When not thinking up bizarre marketing strategies for Max Rev One, Bo enjoys hanging out with friends and simply enjoying life."
        ),
        Founder.new(
            "Menardo Lim",
            "Review Specialist and Head of Program and Planning",
            "Like his colleagues at Max Rev One, Menard is an achiever, and this can be gleaned from his academic life. Menard graduated with a degree of Bachelor of Science in Biology from St. Scholastica's College Tacloban in 2004. Not content with his initial degree, he pursued Nursing at the Our Lady of Mary College, where he graduated in 2011. After passing the rigorous Nurse Licensure Examination in July 2012, he was hired by SRG - Tacloban and later absorbed by Max Rev One. Menard describes himself as simple, unpredictable, and open-minded. His ultimate goal is to become the best in everything that he does."
        )
    ]
  end
end