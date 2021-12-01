##
# https://adventofcode.com/2021/day/1
#
class SonarSweep
  def calculate_simple_total
    numbers.each_cons(2).count { |prev, n| n > prev }
  end

  def calculate_sliding_total
    numbers.each_cons(3).map(&:sum).each_cons(2).count do |prev, n|
      n > prev
    end
  end

  private

  def numbers
    @numbers ||= File.open("./advent_input_1.txt").readlines.map(&:chomp).map(&:to_i)
  end
end

##  Execute
p "simple total:"
pp SonarSweep.new.calculate_simple_total


p "sliding total:"
pp SonarSweep.new.calculate_sliding_total
