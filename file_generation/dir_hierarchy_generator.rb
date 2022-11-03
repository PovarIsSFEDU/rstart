# frozen_string_literal: true

require 'fileutils'
require_relative '../utilities/enums/generation_method'
require_relative '../utilities/exceptions/param_error'
require_relative '../utilities/parser/project_seed_parser'

# Docs
class DirHierarchyGenerator
  def create_base_dir(path, proj_name)
    Dir.chdir(path)
    system("rails new #{proj_name} -qfB")
  end

  def create_file(path, filename)
    File.new(File.join(path, filename), "w").close
  end

  def create_dir(path, dirname)
    Dir.mkdir(File.join(path, dirname))
  end

  def get_files_in_dir(path, folders)
    files = Dir.entries(path).reject {|e| folders.include? e + "/"}
    files.delete('.')
    files.delete('..')
    files.delete('.git')

    return files
  end

  def create_custom_dir_and_files(project_dir, settings)
    settings.hierarchy.each {
      |app_ierarhy|
      if app_ierarhy['type'].eql? 'folder'
        if app_ierarhy['children'] == nil
          raise ParamError, "Invalid format of ierarhy properties!"
        end

        create_project project_dir, app_ierarhy['name']

        app_folder = File.join(project_dir, app_ierarhy['name'])

        folders = Dir.glob("*/", base: app_folder)

        files = get_files_in_dir app_folder, folders

        folders_from_seed = app_ierarhy['children']
                              .select { |child|  child['type'].eql? 'folder'}
                              .map { |child|  child['name'] + "/"}
        files_from_seed = app_ierarhy['children']
                              .select { |child|  child['type'].eql? 'file'}
                              .map { |child|  child['name']}

        folders_from_seed.each { |folder|
          unless folders.include? folder
            create_dir app_folder, folder
          end
        }

        folders = Dir.glob("*/", base: app_folder)

        folders.each { |folder|
          unless folders_from_seed.include? folder
            FileUtils.rm_rf(File.join(app_folder, folder))
          end
        }

        files_from_seed.each { |file|
          unless files.include? file
            create_file app_folder, file
          end
        }

        files = get_files_in_dir app_folder, folders

        files.each { |file|
          unless files_from_seed.include? file
            File.delete(File.join(app_folder, file))
          end
        }

        puts("Create files for application '" + app_ierarhy['name'] + "'")
      elsif app_ierarhy['type'].eql? 'file'
        create_file project_dir, app_ierarhy['name']
        puts("Create file '" + app_ierarhy['name'] + "'")
      end
    }
  end

  def set_custom_properties(project_dir, settings)
    puts("Release")
  end

  def set_custom_dependencies(project_dir, settings)
    puts("Release")
  end

  # Функция определения стратегии создания проекта (default, custom)
  def create_project(project_dir, project_name = "app", generation_mode = GenerationMethod::DEFAULT, project_seed = nil)
    if !generation_mode.eql? GenerationMethod::DEFAULT
      if project_seed.nil?
        raise ParamError, "Seed file is null!"
      end

      settings = ProjectSeedParser.new(project_seed).try_parse
      create_custom_dir_and_files project_dir, settings
      set_custom_properties project_dir, settings
      set_custom_dependencies project_dir, settings
    else
      create_base_dir(project_dir, project_name)
    end
  end
end
