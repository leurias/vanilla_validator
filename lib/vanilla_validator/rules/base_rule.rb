module Rules
	class BaseRule
		attr_accessor :attribute, :value, :parameters

	  def initialize(attribute, value, parameters)
	  	@attribute, @value, @parameters = attribute, value, parameters
	  end

	  private

	  def required
	  	klass = Rules::Required.new(attribute, value, parameters)
	  	klass.valid?
	  end
	end
end