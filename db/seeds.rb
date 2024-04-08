# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
p 'creating one user'
user_one = User.create!(
  email: "paul@gmail.com",
  role: "contributor",
  password: "lknhro;eirthjj095uy4059yu"
)
p 'deletings questions and answers'
 Question.destroy_all

p 'creating 3 questions'
q_one = Question.create!(statement: "Le tireur qui traîne la pointe de son épée sur la piste s’expose",
                         prop_one: "à un carton rouge",
                         prop_two: "n’est passible d’aucune sanction",
                         prop_three: "à un carton jaune",
                         user_id: user_one.id,
                         level: "départemental",
                         category: "épée"
                         )
q_two = Question.create!(statement: "Si l’attaquant remise immédiatement après la parade et que les deux tireurs touchent ; qui est touché ?",
                         prop_one: "l’attaquant",
                         prop_two: "l’attaqué",
                         prop_three: "simultané",
                         user_id: user_one.id,
                         level: "départemental",
                         category: "fleuret")
q_three = Question.create!(statement: "Un tireur redresse sa lame sur la piste après une attaque en pointe",
                           prop_one: "l’arbitre lui demande de remettre sa lame droite",
                           prop_two: "l’arbitre lui donne un carton rouge",
                           prop_three: "l’arbitre lui donne un carton jaune",
                           user_id: user_one.id,
                           level: "départemental",
                           category: "sabre"
                          )

p 'creating 3 answers'
a_one = Answer.create!( explanation: "Trainer sa pointe sur la piste est une faute du 1er groupe sanctionnée par un carton jaune",
                        good_prop: "trois",
                        question_id: q_one.id
                      )
a_two = Answer.create!(explanation: "La riposte est prioritaire sur la remise d'attaque, c'est donc l'attaquant qui est touché",
                        good_prop: "un",
                        question_id: q_two.id
                      )
a_three = Answer.create!(explanation: "Redresser sa lame sur la piste est une faute du 1er groupe sanctionnée par un carton jaune",
                        good_prop: "trois",
                        question_id: q_three.id
                      )
