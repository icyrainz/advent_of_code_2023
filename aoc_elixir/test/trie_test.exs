defmodule TrieTest do
  use ExUnit.Case
  doctest Trie

  test "can get number from tree" do
    trie = Trie.create_root()
    trie = Trie.add_word(trie, 1, "one")
    trie = Trie.add_word(trie, 2, "two")
    trie = Trie.add_word(trie, 3, "three")

    assert Trie.get_word?(trie, "one") == 1
    assert Trie.get_word?(trie, "two") == 2
    assert Trie.get_word?(trie, "three") == 3

    assert Trie.get_word?(trie, "four") == nil
    assert Trie.get_word?(trie, "oone") == nil
  end
end
