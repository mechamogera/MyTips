require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test "report save" do
    report = Report.new({
      :title => 'title',
      :body => 'body'
    })
    assert(report.save, 'Failed to save')
  end

  test "report can't save because title is null" do
    report = Report.new({
      :body => 'body'
    })
    assert(!report.save)
    assert_equal(1, report.errors.count)
    assert_equal(1, report.errors.full_messages.size)
    assert_equal("Title can't be blank", report.errors.full_messages.first)
  end
end
