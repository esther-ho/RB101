=begin
- Ask the user for their name
  - Check if the name is valid
- Ask the user for one number
  - Check if the first number is valid
  - Improve integer validation (allow '0' to be an input)
  - Improve number validation - both integers or floats are valid
- Ask the user for another number
  - Check if the second number is valid
- Ask the user for an operation to perform
  - Check if the operation is valid
  - Display the operation that is being performed
  - Perform the operation on the two numbers
  - Simplify the result
  - Display / Output the result
- Ask the user if they want to repeat the operation again
=end

# Load appropriate prompts from `YAML` file
require 'psych'

config = Psych.load_file('config.yml')

# Add '=>' to all prompts
def prompt(message)
  puts("=> #{message}")
end

# Check if input is a valid number
# Will return false for edge cases e.g. '00', '4.'
def integer?(number)
  number == number.to_i.to_s
end

def float?(number)
  number == number.to_f.to_s
end

def number?(number)
  integer?(number) || float?(number)
end

# Retrieve the appropriate message based on the chosen operator
def operation_to_message(operator, config)
  message = case operator
            when '1'
              config['add']
            when '2'
              config['subtract']
            when '3'
              config['multiply']
            when '4'
              config['divide']
            end
  message
end

# Convert a float to an integer if the float ends with '.0'
def simplify_result(number)
  if number.to_s.end_with?('.0')
    number.to_s.sub('.0', '')
  else
    number.to_s
  end
end

prompt(config['welcome'])

# Check if the user provides a valid name
name = ''
loop do
  name = gets.chomp

  if name.empty?
    prompt(config['valid_name'])
  else
    break
  end
end

prompt("Hi #{name}!")

loop do
  # Check if the first number given is valid
  number1 = ''
  loop do
    prompt(config['first_num'])
    number1 = gets.chomp

    if number?(number1)
      number1 = number1.to_f
      break
    else
      prompt(config['valid_num'])
    end
  end

  # Check if the second number given is valid
  number2 = ''
  loop do
    prompt(config['second_num'])
    number2 = gets.chomp

    if number?(number2)
      number2 = number2.to_f
      break
    else
      prompt(config['valid_num'])
    end
  end

  prompt(config['operator_prompt'])

  # Check if the given operator choice is valid
  operator = ''
  loop do
    operator = gets.chomp

    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt(config['valid_operator'])
    end
  end

  prompt(operation_to_message(operator, config).to_s + config['operator_message'])

  # Perform the appropriate operation
  result =  case operator
            when '1'
              number1 + number2
            when '2'
              number1 - number2
            when '3'
              number1 * number2
            when '4'
              number1 / number2
            end

  prompt(config['result'] + simplify_result(result))

  # Ask user if they want to perform another operation
  prompt(config['again'])
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt(config['bye'])
