#encoding: utf-8
class Founder
  PATH = 'founders/'
  EXT = '.jpg'

  attr_accessor :name, :position, :background, :image

  def initialize(name, position, background)
    @name = name
    @position = position
    @background = background.strip
    @image = "#{PATH}#{name.split(' ').first.downcase.sub('.','')}#{EXT}"
  end

  def self.seed
    [
        Founder.new(
            "Dr. Rommel D. Capungcol, M.D.",
            "President",
            "A full-bodied alumnus of Remedios Trinidad Romualdez Medical Foundation with a Bachelor's Degree in Nursing, Rommel successfully graduated and passed the Nursing board examinations in 1993. This achievement has motivated him to pursue Medicine in the same year and splendidly finished the course in 1997. Eastern Visayas Regional Medical Center served as his fortitude being adopted for internship in 1997-1998 and as a resident-in-training in 1999-2002. His formidable training in the medical center espoused him to pass the medical board in 1998. In 2011, his thirst for professional advancement has been redoubtable as he opted to widen his horizons which imbued him to finish his Master's Degree in Public Administration at Southwestern University in Cebu City. The craving continued when he again took his Master's Degree in Business Administration the following year at the Asian Development Foundation College, Tacloban City. His illustrious personality is apt to serving the robust men and women of the Philippine National Police- Regional Health Service 8 as Medical Officer. He is the concurrent Director of the Philippine National Red Cross - Leyte Chapter, whilst still continue to explore and be edified with another echelon of education being presently enrolled in the College of Law at the Dr. Vicente Orestes Romualdez Educational Foundation, Tacloban City."
        ),
        Founder.new(
            "Jose Van P. Tan, RN",
            "Vice President and Treasurer",
            "Joe graduated at Far Eastern University - Manila in April 2010 with a Bachelor's Degree in Nursing. In the same year, he passed the Nurse Licensure Examination. This idiomatic expression, “strike while the iron is hot,” envisaged him to advocating students' aspirations to succeed in their chosen fields. Hence, he co-founded SRG - Tacloban, the forerunner of Max Rev One. One of his impressive attributes is being able to cope with multi-tasks such as reviewing finances and overseeing the day-to-day operations of Max Rev One, while pursuing his lifelong dream of becoming a lawyer at the Don Vicente Orestes Romualdez Educational Foundation (DVOREF), where he is presently taking Bachelor of Laws."
        ),
        Founder.new(
            "Mariel C. Villaflor-Capungcol",
            "Co-Owner",
            "Mariel graduated her BS in Medical Technology at the Divine Word University. She passed the Medical Technologist Board Examinations in 1989. She believes that learning is a continuous and lifelong process, hence, apart from medical know-how, in 2004, she graduated Bachelor of Laws from Dr. Vicente Orestes Romualdez Educational Foundation. Upholding her principle, she later studied at the Southwestern University, Cebu City where she graduated with a Master's Degree in Public Administration in 2011. Her academic endeavors have been noteworthy as she is one of the competent faculty members of the College of Medical Technology at the Remedios Trinidad Romualdez Medical Foundation."
        ),
        Founder.new(
            "Christine Almedilla-Pablico",
            "Review Specialist and Head of Accounting",
            "Tin is a Nursing graduate of the Remedios Trinidad Romualdez Medical Foundation in April 2007 who subsequently passed the Nurse Licensure Examination in June of the same year. She worked at the Divine Word Hospital in Tacloban City for a while, but she later found a different calling after friends and family gently pushed her to leave her comfort zone. The calling turned out to be joining Max Rev One as a review specialist. Her most important guidepost in life is the saying, With God, everything is possible."
        ),
        Founder.new(
            "Cesar Czarbo P. Trani",
            "Review Specialist and Head of Marketing",
            "Czarbo is a graduate of St. Scholastica's College Tacloban with a degree of Bachelor of Science in Nursing. Prior to taking the Nurse Licensure Examination, he worked part-time as a nurse-researcher for Vantage Medical Review. His hard work soon paid off when he placed 12th in the July 2010 licensure examination with a general rating of 83.6 percent. In October 2010, he was hired as a staff of SRG - Tacloban, where he met his colleagues with whom he formed Max Rev One. When not thinking of bizarre marketing strategies for Max Rev One, Bo enjoys hanging out with friends and simply enjoying life."
        ),
        Founder.new(
            "Menardo Lim",
            "Review Specialist and Head of Program and Planning",
            "Like his colleagues at Max Rev One, Menard is equally an achiever, which is conspicuous in his academic records. He graduated with a degree of Bachelor of Science in Biology from St. Scholastica's College Tacloban in 2004. Not contented with his initial degree, he pursued Nursing at the Our Lady of Mary College, where he graduated in 2011. After passing the rigorous Nurse Licensure Examination in July 2012, he was hired by SRG - Tacloban and later absorbed by Max Rev One. Menard describes himself as simple, unpredictable, and open-minded. His ultimate goal is to become the best in everything that he does."
        )
    ]
  end
end