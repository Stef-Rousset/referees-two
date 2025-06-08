# == Schema Information
#
# Table name: questions
#
#  id         :bigint           not null, primary key
#  statement  :text             not null
#  prop_one   :text             not null
#  prop_two   :text             not null
#  prop_three :text             not null
#  level      :integer          not null
#  category   :integer          not null
#  user_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "test_helper"

class QuestionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
