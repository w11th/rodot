module Rodot
  module Utils
    extend self

    def deep_merge_hashes(target, overwrite)
      deep_merge_hashes!(target.dup, overwrite)
    end

    def deep_merge_hashes!(target, overwrite)
      merge_values(target, overwrite)
      merge_default_proc(target, overwrite)
      duplicate_frozen_values(target)

      target
    end

    def mergable?(value)
      value.is_a?(Hash)
    end

    def duplicable?(obj)
      case obj
      when nil, false, true, Symbol, Numeric
        false
      else
        true
      end
    end

    private

    def merge_values(target, overwrite)
      target.merge!(overwrite) do |_key, old_val, new_val|
        if new_val.nil?
          old_val
        elsif mergable?(old_val) && mergable?(new_val)
          deep_merge_hashes(old_val, new_val)
        else
          new_val
        end
      end
    end

    def merge_default_proc(target, overwrite)
      if target.is_a?(Hash) && overwrite.is_a?(Hash) && target.default_proc.nil?
        target.default_proc = overwrite.default_proc
      end
    end

    def duplicate_frozen_values(target)
      target.each do |key, val|
        target[key] = val.dup if val.frozen? && duplicable?(val)
      end
    end
  end
end
