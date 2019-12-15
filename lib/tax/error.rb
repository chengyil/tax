module Tax
  class Error < StandardError
  end

  class PersonError < Error
  end

  class InvalidMaritalValue < PersonError
  end

  class InvalidDependantValue < PersonError
  end
end
