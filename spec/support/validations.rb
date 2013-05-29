shared_examples_for 'require parameters' do |parameters|
  parameters.each do |parameter|
    it "should raise ArgumentError if #{parameter} is not provided" do
      default_params.delete(parameter)
      expect{ request.call(default_params) }.to raise_error(ArgumentError, "Missing attributes: [:#{parameter}]")
    end
  end
end
