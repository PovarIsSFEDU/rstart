# frozen_string_literal: true

# Docs
class ProjectSeedParser
  @seed_file_ext = '.json'
  @seed_strategy = 'parse_all'

  def initialize(ext: String, strategy: SeedStrategy)
    @seed_file_ext = ext
    @seed_strategy = strategy
  end
end
