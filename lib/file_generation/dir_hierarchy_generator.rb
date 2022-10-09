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

  # Функция определения стратегии создания проекта (default, custom)
  def create_project(project_dir, project_name, generation_mode = GenerationMethod::DEFAULT, project_seed = nil)
    if !generation_mode.eql? 'default'
      if project_seed.nil?
        puts("WARNING! \n Chosen <generation_mode> is #{generation_mode}, but no valid <project_seed> provided!")
        return
      else
        puts('Sorry, NIY :^(')
        return
      end
    else
      create_base_dir(project_dir, project_name)
    end
  end

  # def check_if_abs(path)
  #   # if path
  # end
  #
  # def create_hierarchy
  #   # ``
  # end
end

DirHierarchyGenerator.new.create_base_dir('C:/Users/lukas/Desktop/Projects/ruby_projects/', 'books')
