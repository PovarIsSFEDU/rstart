require 'thor'

class RStart < Thor
  class_option :verbose, :type => :boolean, :aliases => "-v", :desc => "Verbose/No-verbose mode"
  class_option :help, :type => :boolean, :aliases => "-h", :desc => "Help about used commmand"

  class_option :seed, :type => :string, :aliases => "-s", :desc => "Adds a seed-file in json-style to define dependencies and custom project options."

  desc "new [DIRECTORY]", "Create a new rails app"

  def new(directory, seed_file)
    puts("chosen path is: " + directory)
  end

  desc "update", "Update indices of used libraries, try update app version"

  def generate
    puts("NIY error :(")
  end

  desc "version", "Check the app version"

  def version
    puts("RStart v.0.0.1")
  end
end

RStart.start(ARGV)
