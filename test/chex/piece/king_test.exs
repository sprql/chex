defmodule Chex.Piece.KingTest do
  use ExUnit.Case, async: true
  doctest Chex.Piece.King

  test "all moves valid" do
    {:ok, game} = Chex.Game.new("4k3/8/8/8/3K4/8/8/8 w - - 0 1")

    moves = Chex.Piece.King.possible_moves(:white, {:d, 4}, game)

    expected_moves = [
      {:c, 5},
      {:d, 5},
      {:e, 5},
      {:c, 4},
      {:e, 4},
      {:c, 3},
      {:d, 3},
      {:e, 3}
    ]

    assert Enum.sort(moves) == Enum.sort(expected_moves)
  end

  test "king in corner" do
    {:ok, game} = Chex.Game.new("4k3/8/8/8/8/8/8/K7 w - - 0 1")
    moves = Chex.Piece.King.possible_moves(:white, {:a, 1}, game)

    expected_moves = [
      {:a, 2},
      {:b, 2},
      {:b, 1}
    ]

    assert Enum.sort(moves) == Enum.sort(expected_moves)
  end

  test "king surrounded by pawns" do
    {:ok, game} = Chex.Game.new("4k3/8/8/2PPP3/2PKP3/2PPP3/8/8 w - - 0 1")
    moves = Chex.Piece.King.possible_moves(:white, {:d, 4}, game)

    assert moves == []
  end

  test "king blocked diagonally" do
    {:ok, game} = Chex.Game.new("4k3/8/8/2P1P3/3K4/2P1P3/8/8 w - - 0 1")
    moves = Chex.Piece.King.possible_moves(:white, {:d, 4}, game)

    expected_moves = [
      {:d, 5},
      {:c, 4},
      {:e, 4},
      {:d, 3}
    ]

    assert Enum.sort(moves) == Enum.sort(expected_moves)
  end

  test "king must capture to move" do
    {:ok, game} = Chex.Game.new("4k3/8/8/2PPP3/2PKP3/2ppp3/8/8 w - - 0 1")
    moves = Chex.Piece.King.possible_moves(:white, {:d, 4}, game)

    expected_moves = [
      {:c, 3},
      {:d, 3},
      {:e, 3}
    ]

    assert Enum.sort(moves) == Enum.sort(expected_moves)
  end

  test "king blocked by king" do
    {:ok, game} = Chex.Game.new("8/8/3k4/8/3K4/8/8/8 w - - 0 1")
    moves = Chex.Piece.King.possible_moves(:white, {:d, 4}, game)

    expected_moves = [
      {:c, 4},
      {:e, 4},
      {:c, 3},
      {:d, 3},
      {:e, 3}
    ]

    assert Enum.sort(moves) == Enum.sort(expected_moves)
  end

  test "king blocked by pawn" do
    {:ok, game} = Chex.Game.new("4k3/8/3p4/8/3K4/8/8/8 w - - 0 1")
    moves = Chex.Piece.King.possible_moves(:white, {:d, 4}, game)

    expected_moves = [
      {:d, 5},
      {:c, 4},
      {:e, 4},
      {:c, 3},
      {:d, 3},
      {:e, 3}
    ]

    assert Enum.sort(moves) == Enum.sort(expected_moves)
  end

  test "king blocked by pawn with backup" do
    {:ok, game} = Chex.Game.new("4k3/8/2p5/3p4/3K4/8/8/8 w - - 0 1")
    moves = Chex.Piece.King.possible_moves(:white, {:d, 4}, game)

    expected_moves = [
      {:c, 5},
      {:e, 5},
      {:c, 3},
      {:d, 3},
      {:e, 3}
    ]

    assert Enum.sort(moves) == Enum.sort(expected_moves)
  end

  test "mate by pawns" do
    {:ok, game} = Chex.Game.new("4k3/8/2pp4/3pp3/1ppKpp2/8/8/8 w - - 0 1")
    moves = Chex.Piece.King.possible_moves(:white, {:d, 4}, game)

    assert moves == []
  end
end
