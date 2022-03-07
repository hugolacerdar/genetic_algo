defmodule OneMax do
  @behaviour Problem
  alias Types.Chromosome

  @impl true
  def genotype do
    genes = for _ <- 1..1000, do: Enum.random(0..1)
    %Chromosome{genes: genes, size: 1000}
  end

  @impl true
  def fitness_function(chromosome), do: Enum.sum(chromosome.genes)

  @impl true
  def terminate?([_best | _], _generation, temperature), do: temperature < 25
end

soln = Genetic.run(OneMax, population_size: 10)

IO.write("\n")
IO.inspect(soln)
