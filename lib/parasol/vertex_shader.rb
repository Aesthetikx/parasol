# frozen_string_literal: true

module Parasol
  class VertexShader < Parasol::Shader
    def initialize source:
      super source:, type: GL::VERTEX_SHADER
    end
  end
end
