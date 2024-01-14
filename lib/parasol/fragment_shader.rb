# frozen_string_literal: true

module Parasol
  class FragmentShader < Parasol::Shader
    def initialize source:
      super source:, type: GL::FRAGMENT_SHADER
    end
  end
end
