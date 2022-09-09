
# https://stackoverflow.com/a/51012697
SEPERATOR = '.'.freeze

class Hash
  def get_at_explicit_path(path)
    dig(*steps_from(path))
  end

  private
  def steps_from path
    path.split(SEPERATOR).map do |step|
      if step.match?(/\D/)
        step.to_s
      else
        step.to_i
      end
    end
  end
end