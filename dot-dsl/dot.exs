defmodule Graph do
  defstruct attrs: [], nodes: [], edges: []
end

defmodule Dot do
  defmacro graph(do: nil) do
    quote do: %Graph{}
  end

  defmacro graph(do: statements) do
    graph = build_graph(%Graph{}, statements)

    %Graph{attrs: Enum.sort(graph.attrs),
           nodes: Enum.sort(graph.nodes),
           edges: Enum.sort(graph.edges)}
      |> Macro.escape
  end

  def build_graph(graph, {:graph, _, [attributes]}) do
    %{graph | attrs: graph.attrs ++ attributes}
  end

  def build_graph(graph, {:--, _, [{left_node, _, _}, {right_node, _, attributes}]}) when is_atom(right_node) do
    attributes = List.flatten(attributes || [])
    %{graph | edges: [{left_node, right_node, attributes} | graph.edges]}
  end

  def build_graph(graph, {:__block__, _, operations}) do
    Enum.reduce(operations, graph, fn(operation, graph) -> build_graph(graph, operation) end)
  end

  def build_graph(graph, {node_name, _, attributes}) when is_atom(node_name) do
    attributes = List.flatten(attributes || [])

    unless Keyword.keyword?(attributes), do: raise ArgumentError

    %{graph | nodes: [{node_name, attributes} | graph.nodes]}
  end

  def build_graph(_, _) do
    raise ArgumentError
  end
end
