defmodule BlockTest do
  use ExSpec
  doctest Marked

  describe "paragraphs" do

    it "collects all :simple lines" do
      lines = [
        %{type: :simple, content: "a"},
        %{type: :simple, content: "b"},
        %{type: :simple, content: "c"}
      ]

      assert Marked.Block.parse(lines) == "<p>a\nb\nc</p>\n"
    end

    it "breaks paragraphs on :empty lines" do
      lines = [
        %{type: :simple, content: "a"},
        %{type: :simple, content: "b"},
        %{type: :empty},
        %{type: :simple, content: "c"}
      ]

      assert Marked.Block.parse(lines) == "<p>a\nb</p>\n<p>c</p>\n"
    end

  end

  describe "unordered lists" do

    it "collects all :list_item lines" do
      lines = [
        %{type: :list_item, content: "a"},
        %{type: :list_item, content: "b"}
      ]

      assert Marked.Block.parse(lines) == "<ul>\n<li>a</li>\n<li>b</li>\n</ul>\n"
    end

    it "breaks list on :empty lines" do
      lines = [
        %{type: :simple, content: "a"},
        %{type: :simple, content: "b"},
        %{type: :empty},
        %{type: :simple, content: "c"}
      ]

      assert Marked.Block.parse(lines) == "<p>a\nb</p>\n<p>c</p>\n"
    end

  end

  describe "guarded code blocks" do

    it "collects everything between code blocks" do
      lines = [
        %{type: :code_guard, content: ""},
        %{type: :simple, content: "def test:"},
        %{type: :simple, content: "  1+2"},
        %{type: :code_guard, content: ""}
      ]

      assert Marked.Block.parse(lines) == "<pre><code>def test:\n  1+2\n</code></pre>\n"
    end

  end

end
