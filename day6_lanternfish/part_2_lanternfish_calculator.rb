class LanternfishEcosystem
  REPRODUCTIVE_MATURITY_AGE = 6
  SPAWN_AGE = 8
  AGES = (0..SPAWN_AGE).to_a

  def initialize(input, debug: false)
    initial_ages = input.split(",").map(&:to_i)
    @counts_by_age = AGES.map do |age|
      [age, initial_ages.count { |input_age| input_age == age }]
    end.to_h
    @debug = debug
  end

  def predict_count_after_days(days)
    counts_by_age = calculate_reproduction_pattern(@counts_by_age, days)
    pp counts_by_age if @debug

    counts_by_age.values.sum
  end

  private

  def calculate_reproduction_pattern(counts_by_age, remaining_days)
    return counts_by_age if remaining_days.zero?

    new_counts_by_age = AGES.map do |age|
      new_count = case age
                  when 0..5, 7 then counts_by_age[age + 1]
                  when 6 then counts_by_age[age + 1] + counts_by_age[0]
                  when 8 then counts_by_age[0]
                  end
      [age, new_count]
    end.to_h

    calculate_reproduction_pattern(new_counts_by_age, remaining_days - 1)
  end
end

calculator = LanternfishEcosystem.new(DATA.read.chomp)
pp calculator.predict_count_after_days(256)


__END__
1,2,1,1,1,1,1,1,2,1,3,1,1,1,1,3,1,1,1,5,1,1,1,4,5,1,1,1,3,4,1,1,1,1,1,1,1,5,1,4,1,1,1,1,1,1,1,5,1,3,1,3,1,1,1,5,1,1,1,1,1,5,4,1,2,4,4,1,1,1,1,1,5,1,1,1,1,1,5,4,3,1,1,1,1,1,1,1,5,1,3,1,4,1,1,3,1,1,1,1,1,1,2,1,4,1,3,1,1,1,1,1,5,1,1,1,2,1,1,1,1,2,1,1,1,1,4,1,3,1,1,1,1,1,1,1,1,5,1,1,4,1,1,1,1,1,3,1,3,3,1,1,1,2,1,1,1,1,1,1,1,1,1,5,1,1,1,1,5,1,1,1,1,2,1,1,1,4,1,1,1,2,3,1,1,1,1,1,1,1,1,2,1,1,1,2,3,1,2,1,1,5,4,1,1,2,1,1,1,3,1,4,1,1,1,1,3,1,2,5,1,1,1,5,1,1,1,1,1,4,1,1,4,1,1,1,2,2,2,2,4,3,1,1,3,1,1,1,1,1,1,2,2,1,1,4,2,1,4,1,1,1,1,1,5,1,1,4,2,1,1,2,5,4,2,1,1,1,1,4,2,3,5,2,1,5,1,3,1,1,5,1,1,4,5,1,1,1,1,4
