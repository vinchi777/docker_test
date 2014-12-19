class TestFactory
  def self.test(timer = false, published = false, deadline = false)
    timer_count = 0
    timer_count= 30 if timer
    dead = Date.today
    dead = dead + 1.day if !deadline
    t = Test.new(
        description: 'First long exam',
        date: Date.today,
        deadline: dead,
        timer: timer_count,
        review_season: ReviewSeason.first
    )
    t.questions << Question.create(
        text: 'A nurse is providing discharge teaching for a patient with severe Gastroesophogeal Reflux Disease. Which of these statements by the patient indicates a need for more teaching?',
        choice1: '"I’m going to limit my meals to 2-3 per day to reduce acid secretion."',
        choice2: '"I’m going to make sure to remain upright after meals and elevate my head when I sleep"',
        choice3: '"I won’t be drinking tea or coffee or eating chocolate any more."',
        choice4: '"I’m going to start trying to lose some weight."',
        ratio: 'Large meals increase the volume and pressure in the stomach and delay gastric emptying. It’s recommended instead to eat 4-6 small meals a day.',
        answer: 0
    )
    t.questions << Question.create(
        text: ' After being told the patient has been smoking cigarettes for 30 years, the nurse expects to note which assessment finding?',
        choice1: 'Increase in Forced Vital Capacity (FVC)',
        choice2: 'A narrowed chest cavity',
        choice3: 'Clubbed fingers',
        choice4: 'An increased risk of cardiac failure',
        ratio: 'Clubbed fingers are a sign of a long-term, or chronic, decrease in oxygen levels.',
        answer: 1
    )
    t.questions << Question.create(
        text: ' The nurse is taking the health history of a 70-year-old patient being treated for a Duodenal Ulcer. After being told the patient is complaining of epigastric pain, the nurse expects to note which assessment finding?',
        choice1: 'Melena',
        choice2: 'Nausea',
        choice3: 'Hernia',
        choice4: 'Hyperthermia',
        ratio: 'Melena is the finding that there are traces of blood in the stool which presents as black, tarry feces. This is a common manifestation of Duodenal Ulcers, since the Duodenum is further down the gastric anatomy.',
        answer: 2
    )
    t.questions << Question.create(
        text: 'The nurse is working in a support group for clients with HIV. Which point is most important for the nurse to stress?',
        choice1: 'They must inform household members of their condition',
        choice2: 'They must take their medications exactly as prescribed',
        choice3: 'They must abstain from substance use',
        choice4: 'They must avoid large crowds',
        ratio: 'Antiretrovirals must be taken exactly as prescribed to prevent drug-resistant strains. Even missed doses can reduce the effectiveness of future treatment.',
        answer: 3
    )
    t.save
    if published
      ReviewSeason.current.students.each do |s|
        t.create_answer_sheet_for s
      end
    end
    t
  end
end