defmodule Day8 do

  def parse(instruction) do
    String.split(instruction, " ")
    |> (fn [r,o,v,_,cr,co,cv] ->
       %{:reg => r,
         :oper => op(o),
         :val => String.to_integer(v),
         :cond_reg => cr,
         :cond_oper => op(co),
         :cond_val => String.to_integer(cv)}
       end).()
  end

  def computer(program) do
    Enum.reduce(program, %{},
     fn (i, reg) ->
       if run(Map.get(reg, i[:cond_reg], 0), i[:cond_oper], i[:cond_val]) do
         { i[:reg],
           run(Map.get(reg,i[:reg],0), i[:oper], i[:val]),
           reg[:max]}
         |> update_register(reg)
       else reg end
     end
    )
  end
  defp update_register({key, val, max}, reg),
     do: Map.merge(reg, %{key=>val, :max=>Enum.max([max||0, val])})

  def run(left, opr, right) do
    {opr, [context: Elixir, import: Kernel], [left, right]}
    |> Code.eval_quoted |> elem(0)
  end

  def op(opr) do
    case opr do
      "inc" -> :+
      "dec" -> :-
      _ -> String.to_existing_atom(opr)
    end
  end

  def solve1(input) do
    input
    |> read_input
    |> computer
    |> Map.delete(:max)
    |> Map.values
    |> Enum.max
  end

  def solve2(input) do
    input
    |> read_input
    |> computer
    |> Map.get(:max)
  end

  def read_input(file) do
    file
    |> File.read!
    |> String.split("\n")
    |> Enum.map(&parse/1)
  end

end
