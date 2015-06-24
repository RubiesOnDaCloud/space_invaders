module SpaceInvaders
  class Version
    def self.major
      0
    end

    def self.minor
      0
    end

    def self.patch
      0
    end

    def self.pre
      nil
    end

    def self.to_h
      {
        major: major,
        minor: minor,
        patch: patch,
        pre: pre,
      }
    end

    def self.to_a
      to_h.values.compact
    end

    def self.to_s
      to_a.join(".")
    end
  end
end
