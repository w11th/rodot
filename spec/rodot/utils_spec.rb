require 'spec_helper'
RSpec.describe Rodot::Utils do
  describe '#deep_merge_hashes!' do
    before(:context) do
      @target = {
        keep:  1,
        overwrite: 1,
        deepmerge: {
          keep: 1,
          overwrite: 1,
        },
      }
    end

    it 'should keep the old value' do
      overwrite = {}
      keep = @target[:keep]
      Rodot::Utils.deep_merge_hashes!(@target, overwrite)
      expect(@target[:keep]).to eq(keep)
    end

    it 'should overwrite the old value' do
      overwrite = { overwrite: 2 }
      Rodot::Utils.deep_merge_hashes!(@target, overwrite)
      expect(@target[:overwrite]).to eq(overwrite[:overwrite])
    end

    it 'should add new key/value' do
      overwrite = { new: 2 }
      Rodot::Utils.deep_merge_hashes!(@target, overwrite)
      expect(@target[:new]).to eq(overwrite[:new])
    end

    it 'should deepmerge the value' do
      overwrite = { deepmerge: { overwrite: 2, new: 2 } }
      deepmerge_keep = @target[:deepmerge][:keep]
      Rodot::Utils.deep_merge_hashes!(@target, overwrite)
      expect(@target[:deepmerge][:keep]).to eq(deepmerge_keep)
      expect(@target[:deepmerge][:overwrite]).to eq(overwrite[:deepmerge][:overwrite])
      expect(@target[:deepmerge][:new]).to eq(overwrite[:deepmerge][:overwrite])
    end
  end

  describe '#deep_merge_hash' do
    before(:context) do
      @target = {
        keep:  1,
        overwrite: 1,
        deepmerge: {
          keep: 1,
          overwrite: 1,
        },
      }
    end

    it 'should not have side effect' do
      overwrite = { new: 2 }
      Rodot::Utils.deep_merge_hashes(@target, overwrite)
      expect(@target[:new]).to be_nil
    end
  end
end
