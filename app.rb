require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

player1 = Player.new("alice")
player2 = Player.new("bob")

def quit
  printf "Merci d'avoir utilisé notre logiciel !"
end

def start(player1, player2)
  puts "Voici l'état de chaque joueur :" 
  puts "#{player1.name} a #{player1.life_points} points de vie."
  puts "#{player2.name} a #{player2.life_points} points de vie."
  puts "Passons à la phase d'attaque."
end

def combat(player1, player2)
  while player1.life_points > 0 && player2.life_points > 0
    puts "Que souhaites-tu faire, joueur 1 ?"
    printf "1. Attaquer l'autre joueur.\n2. Quitter le jeu.\n"
    choice = gets.chomp.to_i  
    case choice
    when 1
      player1.attacks(player2)
    when 2
      quit()
    end
    if player1.life_points > 0 && player2.life_points > 0
      puts "Que souhaites-tu faire, joueur 2 ?"
      printf "1. Attaquer l'autre joueur.\n2. Quitter le jeu.\n"
      choice = gets.chomp.to_i  
      case choice
      when 1
        player2.attacks(player1)
      when 2
        quit()
      end
    else 
      quit()
    end
  end
end

def perform(player1, player2)
  start(player1, player2)
  combat(player1, player2)
end

perform(player1, player2)


