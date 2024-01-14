# frozen_string_literal: true

module Parasol
  class GeometryShader < Parasol::Shader
    def initialize source:
      super source:, type: GL::GEOMETRY_SHADER
    end
  end
end
