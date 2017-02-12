module Comparitor
  include Comparable

  def inititalize(type)
    Comparitor::Person
  end

  def <=>(secondary)
    score <=> secondary.score
  end
end
