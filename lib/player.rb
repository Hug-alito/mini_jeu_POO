class Player
attr_accessor :name, :life_points

  def initialize(name_to_save)
    @life_points = 10
    @name = name_to_save
  end

  def show_state
    puts "#{name} a #{life_points} points de vie restants."
    puts ""
  end

  def gets_damage(damage)
    if @life_points - damage < 1
      puts "Le joueur #{name} a été tué."
      @life_points = 0
    else
      @life_points = @life_points - damage
    end
    show_state
  end

  def attacks(other_player)
    puts "Le joueur #{name} attaque le joueur #{other_player.name}."
    damage = compute_damage
    puts "Il lui inflige #{damage} points de dégâts.\n\n"
    other_player.gets_damage(damage)
    sleep 0.3
  end

  def compute_damage
    return rand(1..6)
  end

  # Affiche une chaîne de caractères avec un délai de 0.03 seconde entre chaque caractère
  def write(str)
    str.each_char do |char|
      print char
      sleep 0.03
    end
  end

end

class HumanPlayer < Player

  attr_accessor :weapon, :weapon_lvl

  def initialize(name_to_save)
    @life_points = 100
    @name = name_to_save
    @weapon = "épée"
    @weapon_lvl = 1
    write("La schizophrénie dans votre tête : #{name}, tu te souviens de moi ? Je suis là pour t'aider. Ta santé est de #{self.life_points} points de vie, ton arme fait partie de la catégorie #{weapon} et de niveau #{weapon_lvl}.\n")
  end

  def compute_damage
    return rand(1..6) * @weapon_lvl
  end

  def new_weapon
    found_weapon_lvl = rand(1..6)
    if found_weapon_lvl > @weapon_lvl
      @weapon_lvl = found_weapon_lvl
      puts "Zé parti ! Ton arme est maintenant de niveau #{weapon_lvl}"
    else
      puts "Bad luck ! Ton arme n'a pas été améliorée"
    end
  end

  def heal_me_pls
    heal_factor = rand(1..6)
    if heal_factor == 1
      puts "On sait maintenant pourquoi ta famille ne t'a jamais poussé à faire médecine. Tu n'as pas été soigné."
    elsif heal_factor > 1 && heal_factor < 6
      if @life_points + 50 > 100
        @life_points = 100
      else
        @life_points = @life_points + 50
      end
      puts "Tu as su lire les instructions clairement détaillées de la trousse de secours. Tu te soignes de 50 points de vie."
    else
      if @life_points + 80 > 100
        @life_points = 100
      else
        @life_points = @life_points + 80
      end
      puts "Tes anciens réflexes de toxico ont pris le dessus. Tu t'es fait un garrot, tu as fait chauffer le doliprane dans une petite cuillère et tu te l'es injecté. Tu récupères 100 points de vie. Par contre, -20 points parce que la drogue c'est mal."
    end
  end

end
