# frozen_string_literal: true

module Parasol
  # An OpenGL geometry shader which processes primitives between vertex and fragment stages.
  class GeometryShader < Parasol::Shader
    def initialize source:
      super source:, type: GL::GEOMETRY_SHADER
    end
  end
end
