class LanternfishEcosystem
  def initialize(initial_lifeforms)
    @lifeforms = initial_lifeforms.split(',').map(&Lanternfish.method(:new))
  end

  def lifeform_count
    @lifeforms.count
  end

  def simulate_days!(number_of_days, debug: false)
    number_of_days.times do |day|
      @lifeforms.each(&:age_one_day!)
      @lifeforms += @lifeforms.map(&:offspring).compact
      pp "After #{day} days: #{self}" if debug
    end
  end

  def to_s
    @lifeforms.map(&:to_s).join(",")
  end
end

class Lanternfish
  REPRODUCTION_MATURITY = 6

  def initialize(initial_age = 8)
    @reproduction_age = initial_age.to_i
    @will_reproduce = false
  end

  def age_one_day!
    @reproduction_age -= 1

    if @reproduction_age < 0
      @reproduction_age = REPRODUCTION_MATURITY
      @will_reproduce = true
    end
  end

  def offspring
    if @will_reproduce
      @will_reproduce = false
      Lanternfish.new
    end
  end

  def to_s
    @reproduction_age
  end
end

ecosystem = LanternfishEcosystem.new(DATA.read.chomp)

ecosystem.simulate_days!(80)
pp ecosystem.to_s
pp ecosystem.lifeform_count

__END__
1,2,1,1,1,1,1,1,2,1,3,1,1,1,1,3,1,1,1,5,1,1,1,4,5,1,1,1,3,4,1,1,1,1,1,1,1,5,1,4,1,1,1,1,1,1,1,5,1,3,1,3,1,1,1,5,1,1,1,1,1,5,4,1,2,4,4,1,1,1,1,1,5,1,1,1,1,1,5,4,3,1,1,1,1,1,1,1,5,1,3,1,4,1,1,3,1,1,1,1,1,1,2,1,4,1,3,1,1,1,1,1,5,1,1,1,2,1,1,1,1,2,1,1,1,1,4,1,3,1,1,1,1,1,1,1,1,5,1,1,4,1,1,1,1,1,3,1,3,3,1,1,1,2,1,1,1,1,1,1,1,1,1,5,1,1,1,1,5,1,1,1,1,2,1,1,1,4,1,1,1,2,3,1,1,1,1,1,1,1,1,2,1,1,1,2,3,1,2,1,1,5,4,1,1,2,1,1,1,3,1,4,1,1,1,1,3,1,2,5,1,1,1,5,1,1,1,1,1,4,1,1,4,1,1,1,2,2,2,2,4,3,1,1,3,1,1,1,1,1,1,2,2,1,1,4,2,1,4,1,1,1,1,1,5,1,1,4,2,1,1,2,5,4,2,1,1,1,1,4,2,3,5,2,1,5,1,3,1,1,5,1,1,4,5,1,1,1,1,4
