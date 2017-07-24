#!/usr/bin/env ruby

# check arguments

FORCE_UPDATE = ARGV.include?('-f') || ARGV.include?('--force')
HELP_USAGE = ARGV.include?('-h') || ARGV.include?('--help')
DRY_RUN = ARGV.include?('-d') || ARGV.include?('--dry-run')
COUNT_UPDATES = ARGV.include?('-c') || ARGV.include?('--count')

if HELP_USAGE
  puts 'usage:'
  puts '  update brew and brew casks.'
  puts ' '
  puts '  -h , --help : this help message.'
  puts '  -f , --force : force upgrade that newest version is "latest".'
  puts '  -d , --dry-run : experimental , dry run.'
  puts '  -c , --count : experimental , count updatable casks.'
  exit
end

# update brew

module BrewUpdatable
  def message(msg)
    puts "#{msg}" unless COUNT_UPDATES
  end

  def update
    raise NotImplementedError
  end

  def cleanup
    raise NotImplementedError
  end
end

class BrewUpdate
  include BrewUpdatable

  def update
    message 'brew update:'
    message `brew update`

    message 'brew upgrade:'
    message `brew upgrade`
  end

  def cleanup
    message 'brew cleanup:'
    message `brew cleanup`
  end
end

class CasksUpdate
  include BrewUpdatable

  @ignore_item
  attr_reader :update_count

  def initialize
    @ignore_item = [''] #gpgtools']
    @update_count = 0
  end

  def update
    message 'brew cask upgrade'

    `brew cask list`.split("\n").each do |item|
      # ignore when specified it
      next if @ignore_item.include?(item)

      # get most recently version number
      current = `ls -t /usr/local/Caskroom/#{item}/`.split("\n").first.strip
      # get latest version number
      latest = `brew cask info #{item} | grep #{item} | head -n 1`.split(': ')[1].strip

      # output differences
      message "#{item}"
      message "latest  : #{latest}"
      message "current : #{current}"
      message ' '

      # verify
      if latest != current
        if FORCE_UPDATE && latest == 'latest'
          message "#{item} updating.."
          message `brew cask uninstall --force #{item}`
          message `brew cask install #{item}`
          message "#{item} updated !!!"
          message ' '
        elsif DRY_RUN
          # do nothing
        elsif COUNT_UPDATES
          @count = @count + 1
          # do nothing
        else
          message "#{item} updating.."
          message `brew cask uninstall --force #{item}`
          message `brew cask install #{item}`
          message "#{item} updated !!!"
          message ' '
        end
      end
    end
  end

  def cleanup
    message 'brew cask cleanup'
    message `brew cask cleanup`

    message "\nall of done.\n"
  end
end

brew = BrewUpdate.new
brew.update
brew.cleanup

casks = CasksUpdate.new
casks.update
casks.cleanup

if COUNT_UPDATES
  puts casks.update_count
end
