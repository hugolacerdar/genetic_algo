defmodule OneMaxInteractive do
  @behaviour Problem
  alias Types.Chromosome

  @impl true
  def genotype do
    genes = for _ <- 1..10, do: Enum.random(0..1)
    %Chromosome{genes: genes, size: 10}
  end

  @impl true
  def fitness_function(chromosome) do
    IO.inspect(chromosome)
    fit = IO.gets("Rate from 1 to 10:\n")
      fit
      |> String.replace_suffix("\n", "")
      |> String.to_integer()
  end

  @impl true
  def terminate?([best | _], _generation, _temperature), do:  best.fitness == 10
end

soln = Genetic.run(OneMaxInteractive, population_size: 10)

IO.write("\n")
IO.inspect(soln)
