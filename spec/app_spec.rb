require 'spec_helper'

describe 'Statsd Proxy' do
  let(:app) { Sinatra::Application }
  let(:statsd) { stub.as_null_object }
  before { Statsd.stub(:new) { statsd } }

  shared_examples_for "a request that returns empty gif" do
    it 'returns empty gif image' do
      response = get *request
      response.status.should eq(200)
      response.headers['Content-Type'].should eq('image/gif')
    end
  end

  describe '#increment' do
    let(:request) { ['/increment', {name: "test.inc", sample_rate: 0.1}] }
    it 'sends increment request' do
      statsd.should_receive(:increment).with('test.inc', 0.1)
      response = get *request
      response.status.should eq(200)
    end

    it 'does not require sample rate' do
      request[1].delete :sample_rate
      statsd.should_receive(:increment).with('test.inc')
      response = get *request
    end

    it 'does not fail when sample rate cannot be converted to float' do
      request[1][:sample_rate] = 'undefined'
      statsd.should_receive(:increment).with('test.inc')
      response = get *request
    end

    it_behaves_like "a request that returns empty gif"
  end

  describe '#decrement' do
    let(:request) { ['/decrement', {name: "test.dec", sample_rate: 0.1}] }

    it 'sends decrement request' do
      statsd.should_receive(:decrement).with('test.dec', 0.1)
      response = get *request
    end

    it 'does not require sample rate' do
      request[1].delete :sample_rate
      statsd.should_receive(:decrement).with('test.dec')
      response = get *request
    end

    it 'does not fail when sample rate cannot be converted to float' do
      request[1][:sample_rate] = 'undefined'
      statsd.should_receive(:decrement).with('test.dec')
      response = get *request
    end

    it_behaves_like "a request that returns empty gif"
  end

  describe "#timing" do
    let(:request) { ['/timing', {name: "test.timing", value: 100, sample_rate: 0.1}] }
    it 'sends timing request' do
      statsd.should_receive(:timing).with('test.timing', 100, 0.1)
      response = get *request
    end

    it 'does not require sample rate' do
      request[1].delete :sample_rate
      statsd.should_receive(:timing).with('test.timing', 100)
      response = get *request
    end

    it 'does not fail when sample rate cannot be converted to float' do
      request[1][:sample_rate] = 'undefined'
      statsd.should_receive(:timing).with('test.timing', 100)
      response = get *request
    end

    it_behaves_like "a request that returns empty gif"
  end
end
