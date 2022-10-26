# frozen_string_literal: true

# Docs
class NotSupported < StandardError
  def initialize(data)
    @data = data
    super
  end
end
