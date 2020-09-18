module ThoughtsHelper
  def thought
    @thought
  end

  def author_details(thought)
    "@#{author(thought).username} #{author(thought).full_name}"
  end
end
