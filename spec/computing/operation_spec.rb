require 'spec_helper'

describe Tiktalik::Computing::Operation do

  context "instance" do
    let(:subject) { Tiktalik::Computing::Operation.new(OPERATION_STUB)}

    its(:uuid) { should eql("ad9a7aa3-dc61-4dde-92de-af335a635041") }
    its(:start_time) { should eql(Time.parse("2013-05-29 10:38:31 +0200 (UTC)")) }
    its(:end_time) { should eql(Time.parse("2013-05-29 10:39:13 +0200 (UTC)")) }
    its(:description) { should eql("Create_Install: test") }
    its(:progress) { should eql(100) }

  end
end
