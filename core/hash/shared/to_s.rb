require File.dirname(__FILE__) + '/../../../spec_helper'
require File.dirname(__FILE__) + '/../fixtures/classes'

describe :to_s, :shared => true do

  it "returns a string representation with same order as each()" do
    h = new_hash(:a => [1, 2], :b => -2, :d => -6, nil => nil)
    
    pairs = []
    h.each do |key, value|
      pairs << key.inspect + '=>' + value.inspect
    end
    
    str = '{' + pairs.join(', ') + '}'
    h.send(@method).should == str
  end

  it "calls inspect on keys and values" do
    key = mock('key')
    val = mock('val')
    key.should_receive(:inspect).and_return('key')
    val.should_receive(:inspect).and_return('val')
    
    new_hash(key => val).send(@method).should == '{key=>val}'
  end

  # There is an inconsistency in the behaviour of #to_s/#inspect on 1.9.1.
  # ujihisa fixed it and we're waiting for his patch to be committed. See
  # http://redmine.ruby-lang.org/issues/show/1533 for details. 
  ruby_bug "1533", "1.9.1.154" do
    it "handles recursive hashes" do
      x = new_hash
      x[0] = x
      x.send(@method).should == '{0=>{...}}'

      x = new_hash
      x[x] = 0
      x.send(@method).should == '{{...}=>0}'

      x = new_hash
      x[x] = x
      x.send(@method).should == '{{...}=>{...}}'

      x = new_hash
      y = new_hash
      x[0] = y
      y[1] = x
      x.send(@method).should == "{0=>{1=>{...}}}"
      y.send(@method).should == "{1=>{0=>{...}}}"

      x = new_hash
      y = new_hash
      x[y] = 0
      y[x] = 1
      x.send(@method).should == "{{{...}=>1}=>0}"
      y.send(@method).should == "{{{...}=>0}=>1}"
      
      x = new_hash
      y = new_hash
      x[y] = x
      y[x] = y
      x.send(@method).should == "{{{...}=>{...}}=>{...}}"
      y.send(@method).should == "{{{...}=>{...}}=>{...}}"
    end
  end    
end
