require 'operations/add'
require 'operations/comparison'
require 'operations/equals'
require 'operations/exit'
require 'operations/input'
require 'operations/instruction'
require 'operations/jump_if'
require 'operations/jump_if_false'
require 'operations/jump_if_true'
require 'operations/less_than'
require 'operations/multiply'
require 'operations/output'

module Operations
  const_set(:TRUE, 1)
  const_set(:FALSE, 0)
end
