#!/usr/bin/env ruby

puts "brew update:"
puts `brew update`

puts "brew upgrade:"
puts `brew upgrade`

puts "brew cask upgrade"

ignore_item = ['']#gpgtools']

FORCE_UPDATE = ARGV[0] == '-f'

`brew cask list`.split("\n").each do | item |
  # ignore when specified it
  next if ignore_item.include?(item)

  # get most recently version number
  current = `ls -t /usr/local/Caskroom/#{item}/`.split("\n").first.strip
  # get latest version number
  latest = `brew cask info #{item} | grep #{item} | grep #{item} | head -n 1`.split(': ')[1].strip

  # output differences
  puts "#{item}"
  puts "latest  : #{latest}"
  puts "current : #{current}"

  # verify
  if latest != current || FORCE_UPDATE && latest == 'latest'
      puts "#{item} updating.."
      puts `brew cask uninstall --force #{item}`
      puts `brew cask install #{item}`
      puts "#{item} updated !!!"
  end

  puts " "
end

puts "brew cleanup:"
puts `brew cleanup`

puts "brew cask cleanup:"
puts `brew cask cleanup`

puts "\nall of done.\n"
