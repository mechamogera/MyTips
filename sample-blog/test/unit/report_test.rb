require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test "report save" do
    report = Report.new({
      :title => 'title',
      :body => 'body'
    })
    assert(report.save, 'Failed ti save')
  end
end
