module Mongoid
  module Matchers
    module Validations
      class ValidateLengthMatcher < HaveValidationMatcher
        def initialize(field)
          super(field, :length)
        end

        def with_minimum(value)
          @minimum = value
          self
        end
        alias :with_min :with_minimum

        def matches?(klass)
          return false unless @result = super(klass)

          check_minimum if @minimum

          @result
        end

        def description
          desc = []
          desc << " with minimum #{@minimum}" if @minimum
          super << desc.to_sentence
        end

        private

        def check_minimum
          actual = @validator.options[:minimum]
          if actual == @minimum
            @positive_result_message << " with minimum of #{@minimum}"
          else
            @negative_result_message << " with minimum of #{actual}"
            @result = false
          end
        end
      end

      def validate_length_of(field)
        ValidateLengthMatcher.new(field)
      end
    end
  end
end