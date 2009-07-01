require File.dirname(__FILE__) + '/../../spec_helper'
require 'abbrev'

describe "Abbrev::abbrev" do
  it "returns a hash of all unambiguous abbreviations of the array of strings passed in" do
    Abbrev::abbrev(['ruby', 'rules']).should == {"rub" => "ruby",
                                     "ruby" => "ruby",
                                     "rul" => "rules",
                                     "rule" => "rules",
                                     "rules" => "rules"}
    
    Abbrev::abbrev(["car", "cone"]).should == {"ca" => "car", 
                                     "car" => "car", 
                                     "co" => "cone", 
                                     "con" => "cone", 
                                     "cone" => "cone"}                         
  end
  
  it "passing in a pattern as an optional parameter should filter the abbreviations returned in the hash" do
    Abbrev::abbrev(['ruby','rules'],'rub').should == {"ruby"=>"ruby", "rub"=>"ruby"}    
  end
  
  it "returns an empty hash when called on an empty array" do
    Abbrev::abbrev([]).should == {}
  end
end

describe "Array#abbrev" do
  it "returns a hash of all unambiguous abbreviations of the array of strings passed in" do
    ['ruby', 'rules'].abbrev.should == {"rub" => "ruby",
                                     "ruby" => "ruby",
                                     "rul" => "rules",
                                     "rule" => "rules",
                                     "rules" => "rules"}
    
    ["car", "cone"].abbrev.should == {"ca" => "car", 
                                     "car" => "car", 
                                     "co" => "cone", 
                                     "con" => "cone", 
                                     "cone" => "cone"}                         
  end
  
  it "passing in a pattern as an optional parameter should filter the abbreviations returned in the hash" do
    ['ruby','rules'].abbrev('rub').should == {"ruby"=>"ruby", "rub"=>"ruby"}    
  end
  
  it "returns an empty hash when called on an empty array" do
    [].abbrev.should == {}
  end
end

