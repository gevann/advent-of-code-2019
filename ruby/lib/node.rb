class Node
  attr_reader(:name)
  attr_accessor(:parent)

  def initialize(name:)
    @name     = name
    @parent   = nil
  end

  def flat_map
    return enum_for :flat_map unless block_given?

    helper = lambda do |node, acc|
      if node.parent
        helper.(node.parent, [(yield node)] + acc)
      else
        [(yield node)] + acc
      end
    end
    helper.(self, [])
  end
end
