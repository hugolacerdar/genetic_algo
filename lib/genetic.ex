defmodule Genetic do
  def run(fitness_function, genotype, max_fitness, opts \\ []) do
    population = initialize(genotype, opts)
    population
    |> evolve(fitness_function, genotype, max_fitness, opts)
  end

  def evolve(population, fitness_function, genotype, max_fitness, opts \\ []) do
    population = evaluate(population, fitness_function)
    best = hd(population)
    IO.write("|rCurrent Best: #{fitness_function.(best)}")
    if fitness_function.(best) == max_fitness do
      best
    else
      population
      |> select(, opts)
      |> crossover(, opts)
      |> mutation(, opts)
      |> evolve(fitness_function, genotype, max_fitness, opts)
    end
  end

  def initialize(genotype, opts \\ []) do
    for _ <- 1..100, do: genotype.()
  end

  def evaluate(population, fitness_function, opts \\ []) do
    population 
    |> Enum.sort_by(fitness_function, &>=/2)
  end

  def select(population, opts \\ []) do
    population
    |> Enum.chunk_every(2)
    |> Enum.map(&List.to_tuple(&1))
  end

  def crossover(population, opts \\ []) do
    population 
    |> Enum.reduce([],
      fn {p1, p2}, acc -> 
        cx_point = :rand.uniform(length(p1))
        {{h1, t1}, {h2, t2}} = 
          {Enum.split(p1, cx_point),
          Enum.split(p2, cx_point)}
        {c1, c2} = {h1 ++ t2, h2 ++ t1}
        [c1, c2 | acc]
      end)
  end

  def mutation(population, opts \\ []) do
    population 
    |> Enum.map(fn chromossome ->
      if :rand.uniform < 0.05 do
        Enum.shuffle(chromossome)
      else
        chromossome
      end
    end)
  end
end
