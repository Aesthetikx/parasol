# frozen_string_literal: true

module Parasol
  # An OpenGL vertex shader which processes vertex transformations and attributes.
  class VertexShader < Parasol::Shader
    def initialize source:
      super source:, type: GL::VERTEX_SHADER
    end
  end
end
