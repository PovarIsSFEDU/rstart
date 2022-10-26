# frozen_string_literal: false

require 'json'
require 'yaml'
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
      SeedSettings.new(data['dependencies'], data['props'], data['hierarchy'], data['additional_props'])
      # p = SeedSettings.new(data['dependencies'], data['props'], data['hierarchy'], data['additional_props'])
      # puts(data)
    when '.yml'
      seed_file = YAML.load_file(@seed_file_path)
      data = seed_file.inspect
      SeedSettings.new(data['dependencies'], data['props'], data['hierarchy'], data['additional_props'])
      # p = SeedSettings.new(data['dependencies'], data['props'], data['hierarchy'], data['additional_props'])
      # puts(p)
    else
      raise NotSupported, 'This file extension is not supported!'
    end
  end

  def initialize(path = './seed', ext = '.json', strategy = SeedStrategy::PARSE_ALL)
    raise FileNotExist, "Provided file doesn't exist!" unless File.exist? path.concat ext

    @seed_file_path = path
    @seed_file_ext = ext
    @seed_strategy = strategy
  end
end

ProjectSeedParser.new('C:/Users/lukas/Desktop/Projects/ruby_projects/rstart/lib/utilities/parser/seed', '.json').try_parse
