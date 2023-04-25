class Player
attr_accessor :name, :life_points

  def initialize(name_to_save)
    @life_points = 10
    @name = name_to_save
  end

  def show_state
    puts "#{name} a #{life_points} points de vie restants."
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
    puts "Il lui inflige #{damage} points de dégâts."
    other_player.gets_damage(damage)
  end

  def compute_damage
    return rand(1..6)
  end



end
