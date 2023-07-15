def is_palindrome(s)
  s = s.gsub(/[^0-9a-zA-Z]/, '').downcase
  s == s.reverse
end

puts "Enter a string:"
user_input = gets.chomp
if is_palindrome(user_input)
  puts "'#{user_input}' is a palindrome."
else
  puts "'#{user_input}' is not a palindrome."
end

//-----------------------------------------------------------------------------

function is_palindrome($s) {
    $s = preg_replace("/[^0-9a-zA-Z]/", "", strtolower($s));
    return $s === strrev($s);
}

echo is_palindrome("A man, a plan, a canal: Panama") ? 'true' : 'false';  

// Output: true
