# frozen_string_literal: true

# Docs
class DirHierarchyGenerator
  def create_base_dir(path, proj_name)
    # check_if_abs(path)
    Dir.chdir(path)
    system('gem install mini_portile2')
    system('gem install nokogiri -- --use-system-libraries')
    system("rails new #{proj_name}")
    # Dir.mkdir(proj_name)
    # Dir.chdir("./#{proj_name}")
    # create_hierarchy
  end

  def create_custom_base_dir(settings)
    puts('NIY')
  end

  # Функция определения стратегии создания проекта (default, custom)
  def create_project(project_dir, project_name, generation_mode = GenerationMethod::DEFAULT, project_seed = nil)
    if !generation_mode.eql? 'default'
      if project_seed.nil?
        puts("WARNING! \n Chosen <generation_mode> is #{generation_mode}, but no valid <project_seed> provided!")
      else
        settings = ProjectSeedParser.new(project_seed, project_seed).try_parse
        create_custom_base_dir settings
      end
    else
      create_base_dir(project_dir, project_name)
    end
  end

end

DirHierarchyGenerator.new.create_base_dir('C:/Users/lukas/Desktop/Projects/ruby_projects/', 'books')
