require 'spec_helper'

describe 'Statsd Proxy' do
  let(:app) { Sinatra::Application }
  let(:statsd) { stub }
  before { Statsd.stub(:new) { statsd } }

  describe '#increment' do
    let(:request) { ['/increment', {name: "test.inc", sample_rate: 0.1}] }
    it 'sends increment request' do
      statsd.should_receive(:increment).with('test.inc', 0.1)
      response = xhr *request
      response.status.should eq(204)
    end

    it 'does not require sample rate' do
      request[1].delete :sample_rate
      statsd.should_receive(:increment).with('test.inc')
      response = xhr *request
    end
  end

  describe '#decrement' do
    let(:request) { ['/decrement', {name: "test.dec", sample_rate: 0.1}] }

    it 'sends decrement request' do
      statsd.should_receive(:decrement).with('test.dec', 0.1)
      response = xhr *request
      response.status.should eq(204)
    end

    it 'does not require sample rate' do
      request[1].delete :sample_rate
      statsd.should_receive(:decrement).with('test.dec')
      response = xhr *request
    end
  end

  describe "#timing" do
    let(:request) { ['/timing', {name: "test.timing", value: 100, sample_rate: 0.1}] }
    it 'sends timing request' do
      statsd.should_receive(:timing).with('test.timing', 100, 0.1)
      response = xhr *request
      response.status.should eq(204)
    end

    it 'does not require sample rate' do
      request[1].delete :sample_rate
      statsd.should_receive(:timing).with('test.timing', 100)
      response = xhr *request
    end
  end
end
