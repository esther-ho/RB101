=begin
--- P
Input:
- A number - positive, negative or 0
Outputs:
- Returns the negative if the number is positive
- Returns the original number if 0 or negative
Implicit rules:
- Number can be a float or integer
- A valid number is given as the input
--- E
negative(5) == -5
negative(-3) == -3
negative(0) == 0  # There's no such thing as -0 in ruby
--- D

--- A
- If the number is positive,
  - Return the negative of the number
- Else, if the number is 0 or negative,
  - Return the number
=end
