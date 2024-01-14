# frozen_string_literal: true

module Parasol
  # :nodoc:
  module OpenGLContext
    def require_opengl_context!
      return unless GLFW.GetCurrentContext.null?

      fail Parasol::ShaderError, "No OpenGL context available."
    end
  end
end
