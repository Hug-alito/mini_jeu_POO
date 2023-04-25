# frozen_string_literal: true

require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

# L'écran de bienvenue du jeu
def welcome_screen
  progress_bar = "█"
  progress_bar_lenght = 76
  write("Chargement en cours")
  write_long("...\n")
  write("#{progress_bar * progress_bar_lenght} 100%\n\n")
  printf "█████████████████████████████████████████████████████████████████████████████████\n"
  printf "█████████████████ BIENVENUE SUR LE JEU ILS VEULENT TOUS MA POO ██████████████████\n"
  printf "█████████████████████████████████████████████████████████████████████████████████\n"
  puts ""
end

# Affiche une chaîne de caractères avec un délai de 0.03 seconde entre chaque caractère
def write(str)
  str.each_char do |char|
    print char
    sleep 0.03
  end
end

# Affiche une chaîne de caractères avec un délai de 0.50 seconde entre chaque caractère
def write_long(str)
  str.each_char do |char|
    print char
    sleep 0.50
  end
end

# Création du joueur humain
def new_humanplayer
  printf "Vous : " 
  write_long("Mhhmh...")
  sleep 1
  write_long(" ... ")
  write("Mais !?? Où suis-je ???\n")
  printf "POOtecteur : "
  write("Réveille-toi !!! Tu as bien été POOtré... \nLe village est en feu ! Il faut protéger ta POO ! Quel est ton nom, jeune aventurier ?\n> ")
  name = gets.chomp
  HumanPlayer.new(name)
end

# Création des ennemies
def your_ennemies
  enemies = []
  enemy_names = ["Maléficar", "Azrael", "Lilithia", "Thulsa", "Valtor", "Xarathos", "Zarek", "Nyxen", "Mordekai", "Dravena"]
  printf "POOtecteur : "
  write("Ok beau-gosse ! Tu as de beaux yeux tu sais... Enfin, je m'égare. Dernièrement, notre plus grand ennemi a lancé des mercenaires à nos trousses. Je ne me souviens plus de toute l'histoire. Combien sont-ils déjà ?\n> ")
  number_of_enemies = gets.chomp.to_i

  # Ajout de sécurité pour empêcher le nombre d'ennemis de descendre en dessous de 1 et de dépasser 10
  while number_of_enemies < 1 || number_of_enemies > 10
    write("POOtecteur : On se détend mon brave, tout va bien se passer. Je perds la POOle mais pas à ce POOint. Il me semble qu'ils étaient entre 1 et 10. ")
    write("Combien sont-ils ?\n> ")
    number_of_enemies = gets.chomp.to_i
  end

  # Création des ennemies avec des noms aléatoires
  shuffled_enemy_names = enemy_names.shuffle
  number_of_enemies.times do |enemy|
    enemy_name = shuffled_enemy_names[enemy]
    enemies << Player.new(enemy_name)
  end
  return enemies
end

# Pour se barrer
def quit
  printf "Merci d'avoir utilisé notre petit-jeu !"
  exit
end

# Ça commence ! Les voilà ! 
def start(enemies, humanplayer)
  write("\nAh oui ! C'est vrai... À tous les POO, ces POOtits merdeux sont :\n")
  enemies.each_with_index do |enemy, index|
    puts "#{enemy.name}, mercenaire n°#{index + 1}, qui a #{enemy.life_points} POOints de vie."
    sleep 0.5
  end
  printf "Toi, tu as #{humanplayer.life_points} POOints de vie.\n\n"
  printf "POOtain !!! Pas l'temps d'niaiser ! Les v'là !\n"
end

# Et c'est parti pour le show ! 
def combat(enemies, humanplayer)
  while humanplayer.life_points > 0 && !enemies.empty?
    menu(enemies, humanplayer)
    enemies.each do |enemy|
      enemy.attacks(humanplayer)
      if humanplayer.life_points < 1
        puts "T'es mort pauvre tache.\n"
        quit()
      end
    end
    enemies.each do |enemy|
      puts "#{enemy.name} a #{enemy.life_points} points de vie.\n"
    end
  end
  if humanplayer.life_points < 1
    puts "T'es mort pauvre tache.\n"
    quit()
  end
end

# Pour savoir quoi faire au bon moment ! 
def menu(enemies, humanplayer)
  puts "\nQue souhaites-tu faire, aventurier ?"
  printf "1. Attaquer un ennemi.\n2. Trouver une meilleure arme.\n3. Trouver des soins.\n4. T'enfuir comme un lâche.\n"
  choice = gets.chomp.to_i  
  case choice
  when 1
    puts "\nQuel ennemi ?"
    enemies.each_with_index do |enemy, index|
      puts "#{index + 1}. #{enemy.name} (#{enemy.life_points} PV)"
    end
    which = gets.chomp.to_i
    while which <= 0 || which > enemies.length
      printf "POOtecteur : "
      write("T'as du POO dans les yeux ! Vise un ennemi qui existe.")
      which = gets.chomp.to_i
    end    
      if which > 0 && which <= enemies.length
        player = enemies[which - 1]
        humanplayer.attacks(player)
        if player.life_points < 1
          enemies.delete(player)
          puts "\n†††††††††† L'ennemi #{which} est mort. Yes, le monstre est DEAD. ††††††††††\n\n"
        end
      end
  when 2
    humanplayer.new_weapon
  when 3
    humanplayer.heal_me_pls
  when 4
    quit()
  end
end

# La cinématique de fin - GG !
def the_end_of_the_game
  printf "POOtecteur : "
  write("Je n'ai jamais douté de toi... Ton physique parfait et ton intelligence incroyable sont venus à bout de ces POOtains de monstres. Tu es le POOrfendeur divin ! ÉPOOse-moi !")
end

# Les rouages sont graissés 
def perform
  welcome_screen
  humanplayer = new_humanplayer
  enemies = your_ennemies
  start(enemies, humanplayer)
  combat(enemies, humanplayer)
  the_end_of_the_game
end

# Lezgo
perform
