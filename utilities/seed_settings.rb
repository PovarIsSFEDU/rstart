# frozen_string_literal: false

# Doc
class SeedSettings
  attr_accessor :dependencies, :props, :hierarchy

  def initialize(deps, props, hierc)
    @dependencies = deps
    @props = props
    @hierarchy = hierc
  end
end
