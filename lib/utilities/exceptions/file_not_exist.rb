# frozen_string_literal: true

# Docs
class FileNotExist < StandardError
  def initialize(data)
    @data = data
    super
  end
end
