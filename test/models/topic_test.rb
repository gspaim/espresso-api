require 'test_helper'

class TopicTest < ActiveSupport::TestCase
  test "should not save topic without title" do
    topic = Topic.new
    assert_not topic.save
  end
end
