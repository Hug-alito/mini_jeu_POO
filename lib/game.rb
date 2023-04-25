class Game
  
  def initialize
    puts "Voici l'état de chaque joueur :" 
    puts "#{player1.name} a #{player1.life_points} points de vie."
    puts "#{player2.name} a #{player2.life_points} points de vie."

    puts "Passons à la phase d'attaque."
  end

end