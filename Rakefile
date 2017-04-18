require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

desc "Transfer mackup cfg file to rodot yml file"
task :transfer_mackup_cfg do
  source_path = './config/mackup/applications'
  dest_path = './config/applications'

  Dir.foreach(source_path) do |source_file_name|
    next unless source_file_name =~ /\.cfg$/

    # file name from 'multi-word-2.cfg' to 'multi_word@2.yml'
    dest_file_name = "#{File.basename(source_file_name, '.cfg').tr('-', '_').gsub(/_?(\d+)$/, '@\\1')}.yml"

    File.open(File.expand_path(source_file_name, source_path)) do |source_file|
      dotfiles = []
      while line = source_file.gets
        next if /^\s*$/ =~ line
        next if /^\s*[#|;]/ =~ line
        next if line.split[0].casecmp('rem') && /r|R/ =~ line[0]

        if /\[(?<header>[^\]]+)\]/ =~ line
          current_header = header
        else
          raise "Parse Error: no header exsits. cfg file: #{source_file_name} on line #{source_file.lineno}" unless current_header
          case current_header
          when 'application'
            # ignore application name
          when 'configuration_files'
            dotfiles << line.strip
          else
            p "Unknown header #{current_header}. cfg file: #{source_file_name} on line #{source_file.lineno}"
          end
        end
      end
      if dotfiles.empty?
        p "Dotfiles empty: #{dest_file_name}, cfg file: #{source_file_name}"
        next
      else
        File.open(File.expand_path(dest_file_name, dest_path), 'w') do |dest_file|
          dest_file.puts('dotfiles:')
          dotfiles.each do |dotfile|
            dest_file.puts("  - #{dotfile}")
          end
          p "Yaml file written: #{dest_file_name}"
        end
      end
    end
  end
end
