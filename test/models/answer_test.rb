# == Schema Information
#
# Table name: answers
#
#  id          :bigint           not null, primary key
#  explanation :text             not null
#  good_prop   :integer          not null
#  question_id :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require "test_helper"

class AnswerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
