# frozen_string_literal: true

module Parasol
  # An OpenGL fragment shader which processes pixel color output.
  class FragmentShader < Parasol::Shader
    def initialize source:
      super source:, type: GL::FRAGMENT_SHADER
    end
  end
end
