#!/usr/bin/env ruby

# check arguments

FORCE_UPDATE = ARGV.include?('--force')
HELP_USAGE = ARGV.include?('-h') || ARGV.include?('--help')
DRY_RUN = ARGV.include?('-d') || ARGV.include?('--dry-run')
FORCE_DRY_RUN = ARGV.include?('--force-dry-run')
UPDATE_COUNT_ONLY = ARGV.include?('-c') || ARGV.include?('--count')

if HELP_USAGE
  puts 'usage:'
  puts '  upgrade brew and brew casks.'
  puts ' '
  puts '  -h , --help     : this help message.'
  puts '  --force         : force upgrade that newest version is "latest" or "auto_updates".'
  puts '  -d , --dry-run  : dry run ( not includes "latest" and "auto_updates" ) but execute brew update, brew cleanup.'
  puts '  --force-dry-run : dry run ( includes "latest" and "auto_updates" ) but execute brew update, brew cleanup.'
  puts '  -c , --count    : count updatable casks. for bitbar plugin: https://github.com/positrium/bitbar-brew-cask-upgrade-all'
  puts ' '
  exit
end

# update brew

class BrewUpdate
  def update
    puts 'brew update:'
    puts `brew update`

    puts 'brew upgrade:'
    puts `brew upgrade`
  end

  def cleanup
    puts 'brew cleanup:'
    puts `brew cleanup`
  end
end

class CasksUpdate

  @ignore_items
  @items
  attr_reader :update_count

  def initialize
    @ignore_items = []
    @update_count = 0
    @items = `brew cask list`.split("\n")
    @items = @items - @ignore_items
  end

  def update
    puts 'brew cask upgrade:'
    @items.each do |item|
      if updatable(item)
        unless self_updatable(item)
          # output differences
          differently_info(item)

          update_item(item)
        end
      end
    end
  end

  def count_up_update_items
    @items.each do |item|
      @update_count = @update_count + 1 if updatable(item)
    end
  end

  def force_update
    puts 'brew cask force upgrade:'

    @items.each do |item|
      if updatable(item)
        if self_updatable(item)
          # output differences
          differently_info(item)

          force_update_item(item)
        end
      end
    end
  end

  def dry_run
    puts 'brew cask upgrade dry-run:'

    @items.each do |item|
      if updatable(item)
        unless self_updatable(item)

          # output differences
          differently_info(item)

          dry_run_item(item)
        end
      end
    end
  end

  def force_dry_run
    puts 'brew cask upgrade force-dry-run:'

    @items.each do |item|
      if updatable(item)
        if self_updatable(item)

          # output differences
          differently_info(item)

          dry_run_item(item)
        end
      end
    end
  end

  def cleanup
    puts 'brew cask cleanup'
    puts `brew cask cleanup`

    puts "\nall of done.\n"
  end

  private

  # judge self-updatable item
  def self_updatable(item)
    true if latest(item) == 'latest'
    true if latest(item).include?('auto_updates')
  end

  # output differences
  def differently_info(item)
    puts "#{item}"
    puts "latest  : #{latest(item)}"
    puts "current : #{current(item)}"
    puts ' '
  end

  # get most recently version number
  def current(item)
    `ls -t /usr/local/Caskroom/#{item}/`.split("\n").first.strip
  end

  # get latest version number
  def latest(item)
    `brew cask info #{item} | grep #{item} | head -n 1`.split(': ')[1].strip
  end

  def updatable(item)
    latest(item) != current(item)
  end

  def force_update_item(item)
    puts "#{item} updating.."
    puts `brew cask uninstall --force #{item}`
    puts `brew cask install #{item}`
    puts "#{item} updated !!!"
    puts ' '
  end

  def dry_run_item(item)
    puts "#{item} can update !"
    puts ' '
  end

  def update_item(item)
    puts "#{item} updating.."
    puts `brew cask uninstall --force #{item}`
    puts `brew cask install #{item}`
    puts "#{item} updated !!!"
    puts ' '
  end
end

brew = BrewUpdate.new
brew.update
brew.cleanup

casks = CasksUpdate.new

if FORCE_UPDATE
  casks.force_update
  casks.cleanup
elsif FORCE_DRY_RUN
  casks.force_dry_run
elsif DRY_RUN
  casks.dry_run
elsif UPDATE_COUNT_ONLY
  casks.count_up_update_items
  puts casks.update_count
else
  casks.update
  casks.cleanup
end
