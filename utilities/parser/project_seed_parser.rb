# frozen_string_literal: false

require 'json'
require 'yaml'
require 'pathname'
require_relative '../seed_settings'
require_relative '../exceptions/file_not_exist'
require_relative '../exceptions/not_supported'
require_relative '../enums/seed_strategy'

# Docs
class ProjectSeedParser
  attr_accessor :seed_file_path, :seed_file_ext, :seed_strategy

  def try_parse
    case @seed_file_ext
    when '.json'
      seed_file = File.open(@seed_file_path)
      data = JSON.load seed_file
      puts(data.class)
      SeedSettings.new(data['dependencies'], data['props'], data['hierarchy'], data['additional_props'])
    when '.yml'
      seed_file = File.open(@seed_file_path)
      data = YAML.load seed_file
      SeedSettings.new(data['dependencies'], data['props'], data['hierarchy'], data['additional_props'])
    else
      raise NotSupported, 'This file extension is not supported!'
    end
  end

  def initialize(path = './seed', strategy = SeedStrategy::PARSE_ALL)
    raise FileNotExist, "Provided file doesn't exist!" unless Pathname.new(path).exist?

    @seed_file_path = path
    @seed_file_ext = File.extname(path)
    @seed_strategy = strategy
  end
end
