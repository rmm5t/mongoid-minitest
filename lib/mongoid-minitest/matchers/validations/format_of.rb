module Mongoid
  module Matchers
    module Validations
      class ValidateFormatMatcher < HaveValidationMatcher
        def initialize(field)
          super(field, :format)
        end

        def to_allow(valid_value)
          @valid = valid_value
          self
        end

        def matches?(klass)
          return false unless @result = super(klass)

          check_valid_value if @valid

          @result
        end

        def description
          desc = []
          desc << " allowing the value #{@valid.inspect}" if @valid
          super << desc.to_sentence
        end

        private

        def check_valid_value
          if format =~ @valid
            @positive_message = @positive_message << " with #{@valid.inspect} as a valid value"
          else
            @negative_message = @negative_message << " with #{@valid.inspect} as an invalid value"
            @result = false
          end
        end

        def format
          @validator.options[:with]
        end
      end

      def validate_format_of(field)
        ValidateFormatMatcher.new(field)
      end
    end
  end
end
