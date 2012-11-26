require 'spec_helper'

describe Merchant do
  it { should have_many :items }
  it { should have_many :purchases }
end
