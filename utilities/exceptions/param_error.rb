# frozen_string_literal: true

# Docs
class ParamError < StandardError
  def initialize(data)
    @data = data
    super
  end
end

