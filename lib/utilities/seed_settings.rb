# frozen_string_literal: false

# Doc
class SeedSettings
  attr_accessor :dependencies, :props, :hierarchy, :additional_props

  def initialize(deps, props, hierc, add_props)
    @dependencies = deps
    @props = props
    @hierarchy = hierc
    @additional_props = add_props
  end
end
