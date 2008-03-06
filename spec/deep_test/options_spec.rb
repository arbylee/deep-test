require File.dirname(__FILE__) + "/../spec_helper"

module DeepTest
  describe Options do
    it "should support number_of_workers" do
      Options.new(:number_of_workers => 3).number_of_workers.should == 3
    end

    it "should have reasonable defaults" do
      options = Options.new({})
      options.number_of_workers.should == 2
      options.timeout_in_seconds.should == 30
      options.pattern.should == nil
    end

    it "should support timeout_in_seconds" do
      Options.new(:timeout_in_seconds => 2).timeout_in_seconds.should == 2
    end

    it "should support pattern" do
      Options.new(:pattern => '*').pattern.should == '*'
    end

    it "should support strings as well as symbols" do
      Options.new("number_of_workers" => 2).number_of_workers.should == 2
    end

    it "should raise error when invalid option is specifed" do
      lambda {
        Options.new(:foo => 1)
      }.should raise_error(Options::InvalidOptionError)
    end

    it "should convert to command line option string" do
      options = Options.new(:number_of_workers => 2, :timeout_in_seconds => 3)
      options.to_command_line.should == 
        "--number_of_workers 2 --timeout_in_seconds 3"
    end

    it "should parse from command line option string" do
      options = Options.from_command_line( 
        "--number_of_workers 2 --timeout_in_seconds 3 --pattern *")
      options.number_of_workers.should == 2
      options.timeout_in_seconds.should == 3
      options.pattern.should == '*'
    end
  end
end
