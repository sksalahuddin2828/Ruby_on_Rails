# gem install bigdecimal
# gem install matrix
# gem install symbo

require 'bigdecimal'
require 'bigdecimal/util'
require 'matrix'
require 'symbo'

# Number of program 1
square_root_2 = Math.sqrt(2).to_d
puts square_root_2

# Number of program 2
half = Rational(1, 2)
third = Rational(1, 3)
sum_result = half + third
puts sum_result

# Number of program 3
var_x, var_y = Symbo.symbols('x y')
binomial_expr = (var_x + var_y)**6
expanded_expr = binomial_expr.expand
puts expanded_expr

# Number of program 4
var_x = Symbo.symbols('x')
trig_expr = Symbo.sin(var_x) / Symbo.cos(var_x)
simplified_expr = trig_expr.simplify
puts simplified_expr

# Number of program 5
var_x = Symbo.symbols('x')
equation = (Symbo.sin(var_x) - var_x) / (var_x**3)
solution_set = equation.solve(var_x)
puts solution_set

# Number of program 6
var_x = Symbo.symbols('x')
log_expr = Symbo.log(var_x)
log_derivative = log_expr.diff(var_x)
log_derivative_value = log_derivative.subs(var_x, 1)
puts "Derivative of log(x) with respect to x: #{log_derivative}"
puts "Value of the derivative: #{log_derivative_value}"

inverse_expr = 1 / var_x
inverse_derivative = inverse_expr.diff(var_x)
inverse_derivative_value = inverse_derivative.subs(var_x, 1)
puts "Derivative of 1/x with respect to x: #{inverse_derivative}"
puts "Value of the derivative: #{inverse_derivative_value}"

sin_expr = Symbo.sin(var_x)
sin_derivative = sin_expr.diff(var_x)
sin_derivative_value = sin_derivative.subs(var_x, 0)
puts "Derivative of sin(x) with respect to x: #{sin_derivative}"
puts "Value of the derivative: #{sin_derivative_value}"

cos_expr = Symbo.cos(var_x)
cos_derivative = cos_expr.diff(var_x)
cos_derivative_value = cos_derivative.subs(var_x, 0)
puts "Derivative of cos(x) with respect to x: #{cos_derivative}"
puts "Value of the derivative: #{cos_derivative_value}"

# Number of program 7
var_x, var_y = Symbo.symbols('x y')
equation1 = var_x + var_y - 2
equation2 = 2 * var_x + var_y
solution_dict = Symbo.solve([equation1, equation2], [var_x, var_y])
puts "x = #{solution_dict[var_x]}"
puts "y = #{solution_dict[var_y]}"

# Number of program 8
var_x = Symbo.symbols('x')
integrated_expr1 = var_x**2.integrate(var_x)
puts "Integration of x^2: #{integrated_expr1}"

integrated_expr2 = Symbo.sin(var_x).integrate(var_x)
puts "Integration of sin(x): #{integrated_expr2}"

integrated_expr3 = Symbo.cos(var_x).integrate(var_x)
puts "Integration of cos(x): #{integrated_expr3}"

# Number of program 9
var_x = Symbo.symbols('x')
function_f = Symbo.Function('f').call(var_x)
differential_equation = function_f.diff(var_x, var_x) + 9 * function_f - 1
solution = Symbo.dsolve(differential_equation, function_f)
puts solution

# Number of program 10
var_x, var_y, var_z = Symbo.symbols('x y z')
coefficient_matrix = Matrix[[3, 7, -12], [4, -2, -5]]
constants = Matrix[[0], [0]]
solution_set = coefficient_matrix.lup.solve(constants)
puts "x = #{solution_set[0, 0]}"
puts "y = #{solution_set[1, 0]}"
