require 'spec_helper'

describe 'Statsd Proxy' do
  let(:app) { Sinatra::Application }
  let(:statsd) { stub }
  before { Statsd.stub(:new) { statsd } }

  shared_examples_for "a request that only allows ajax" do
    it 'only allow ajax request' do
      response = get *request
      response.status.should eq(403)
    end
  end

  describe '#increment' do
    let(:request) { ['/increment', {name: "test.inc", sample_rate: 0.1}] }
    it 'sends increment request' do
      statsd.should_receive(:increment).with('test.inc', 0.1)
      response = xhr *request
      response.status.should eq(204)
    end

    it_behaves_like "a request that only allows ajax"
  end

  describe '#decrement' do
    let(:request) { ['/decrement', {name: "test.dec", sample_rate: 0.1}] }

    it 'sends decrement request' do
      statsd.should_receive(:decrement).with('test.dec', 0.1)
      response = xhr *request
      response.status.should eq(204)
    end

    it_behaves_like "a request that only allows ajax"
  end

  describe "#timing" do
    let(:request) { ['/timing', {name: "test.timing", value: 100, sample_rate: 0.1}] }
    it 'sends timing request' do
      statsd.should_receive(:timing).with('test.timing', 100, 0.1)
      response = xhr *request
      response.status.should eq(204)
    end

    it_behaves_like "a request that only allows ajax"
  end
end
