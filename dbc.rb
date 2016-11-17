module DBC

  # Support pour l'approche DBC... tres informel et "light"!

  module_function

  def assert( condition, message = nil )
    fail "Assertion failed: #{message}" unless condition
  end

  def requires( condition, message = nil )
    fail "Precondition failed: #{message}" unless condition
  end

  def ensures( condition, message = nil )
    fail "Postcondition failed: #{message}" unless condition
  end
end
