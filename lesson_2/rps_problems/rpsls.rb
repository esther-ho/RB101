=begin
- Ask user if they would like to view instructions
- Get input from the user
  - Multiple ways to indicate a valid input (e.g. '1', 'rock', 'r')
  - Convert user input into a valid input
- Sample a input from possible choices for the computer
  - Provide a list of possible choices
- Determine if player or computer won
  - Possible combinations of winning depending on input
  - Print the appropriate message if player win/loses/ties
- Repeat RPSLS program until there are 3 wins
  - Keep track of number of wins for player and computer
  - Print out number of wins, loses, ties after each round
- Repeat game if player answers 'y'
  - Keep track of number of rounds player has played
  - Number of rounds won or lost

=end

require 'psych'

CONFIG = Psych.load_file('config_rpsls.yml')
CHOICES = CONFIG['choices']

def message(key)
  CONFIG['prompts'][key]
end

def prompt(key)
  puts "=> #{message(key)}"
end

def valid_name
  name = ''

  loop do
    prompt('name')
    name = gets.chomp.strip
    break if /^[[:alpha:]]+\ ?[[:alpha:]]*$/.match(name)
    prompt('valid_name')
  end

  name.split.map(&:capitalize).join(' ')
end

def find_choice(input)
  CHOICES.select do |_, v|
    v['inputs'].include?(input)
  end.keys.first
end

def valid_choice
  choice = ''

  loop do
    prompt('choice')
    prompt('choice_example')
    input = gets.chomp.strip.downcase
    choice = find_choice(input)
    break if choice
    prompt('valid_choice')
  end

  choice
end

def win?(first, second)
  CHOICES[first]['beat'].include?(second)
end

def who_wins(player, computer)
  if win?(player, computer)
    message('win_message').sample
  elsif win?(computer, player)
    message('lose_message').sample
  else
    message('tie_message').sample
  end
end

system 'clear'
prompt('welcome')
name = valid_name

system 'clear'
puts message('greeting') + name + '!'

loop do
  player = valid_choice
  computer = CHOICES.keys.sample
  puts who_wins(player, computer)
  break
end
