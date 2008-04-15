require File.dirname(__FILE__) + "/../../../test_helper"

unit_tests do
  test "make_exception_marshallable wraps exception in a mashallable exception" do
    error = Test::Unit::Error.new "test_name", Exception.new("message")
    error.make_exception_marshallable

    assert_kind_of DeepTest::MarshallableException, error.instance_variable_get(:@exception)
    assert_kind_of Exception, error.exception
  end

  test "calling make_exception_marshallable twice only wraps exception once" do
    error = Test::Unit::Error.new "test_name", Exception.new("message")
    error.make_exception_marshallable
    error.make_exception_marshallable

    assert_kind_of Exception, error.exception
  end

  test "error is accessible as normal when it has not been made marshallable" do
    error = Test::Unit::Error.new "test_name", e = Exception.new("message")
    assert_equal e, error.exception
  end
end
