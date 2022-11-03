# frozen_string_literal: true

require 'thor'
require_relative 'file_generation/dir_hierarchy_generator'
require_relative 'utilities/enums/generation_method'

# Docs
class RStart < Thor
  class_option :verbose, type: :boolean, aliases: '-v', desc: 'Verbose/No-verbose mode'
  class_option :help, type: :boolean, aliases: '-h', desc: 'Help about used command'

  desc 'new -p [path] -s [seed_file]', 'Create a new rails app in [path] with a [seed] props and names'

  def new
    if options[:help]
      if options[:path] && options[:seed]
        puts("This command will generate rails project in dir '#{options[:path]}' with given seed-file '#{options[:seed]}'")
        return
      elsif options[:seed].nil?
        puts("This command will generate rails project in dir #{options[:path]} with default seed-file")
        return
      end
    end

    system('gem install mini_portile2')
    system('gem install nokogiri -- --use-system-libraries')

    if options[:project_name].nil?
      if options[:seed].nil?
        DirHierarchyGenerator.new.create_project options[:path]
      else
        DirHierarchyGenerator.new.create_project options[:path], "app", GenerationMethod::CUSTOM, options[:seed]
      end
    else
      if options[:seed].nil?
        DirHierarchyGenerator.new.create_project options[:path], options[:project_name]
      else
        DirHierarchyGenerator.new.create_project options[:path], options[:project_name], GenerationMethod::CUSTOM, options[:seed]
      end
    end
  end

  method_option :path, type: :string, aliases: '-p',
                desc: 'Define path',
                for: :new

  method_option :project_name, type: :string, aliases: '--name',
                desc: 'Set name for generated project. Default name is \"app\"',
                for: :new

  method_option :seed, type: :string, aliases: '-s',
                desc: 'Adds a seed-file in json-style to define dependencies and custom project options.',
                for: :new

  desc 'update', 'Update indices of used libraries, try update app version'

  def update
    puts('NIY error :(')
  end

  desc 'version', 'Check the app version'

  def version
    puts('RStart v.0.0.1')
  end
end

RStart.start(ARGV)
