module Tax
  class Error < StandardError;end

  class ConfigError < StandardError;end

  class PersonError < Error;end
  
  class IDRError < Error;end

  class InvalidMaritalValue < PersonError;end

  class InvalidDependantValue < PersonError;end

  class InvalidDependantValue < PersonError;end

  class InvalidMonthlyIncomeValue < PersonError;end
end
