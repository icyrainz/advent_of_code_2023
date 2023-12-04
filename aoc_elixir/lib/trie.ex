defmodule TrieNode do
  defstruct value: nil, children: %{}, is_leaf: false
end

defmodule Trie do
  def create_root() do
    %TrieNode{}
  end

  def add_word(node, value, []) do
    %TrieNode{node | is_leaf: true, value: value}
  end

  def add_word(node, value, word) do
    [first_letter | rest] = word |> to_charlist()

    updated_children =
      case node.children[first_letter] do
        nil ->
          node.children
          |> Map.put(first_letter, add_word(%TrieNode{}, value, rest))

        child_node ->
          node.children
          |> Map.put(first_letter, add_word(child_node, value, rest))
      end

    %TrieNode{children: updated_children}
  end

  def get_word?(node, []), do: node.value

  def get_word?(node, word) do
    [first_letter | rest] = word |> to_charlist()

    case node.children[first_letter] do
      nil ->
        nil

      child_node ->
        if child_node.is_leaf do
          child_node.value
        else
          get_word?(child_node, rest)
        end
    end
  end
end
