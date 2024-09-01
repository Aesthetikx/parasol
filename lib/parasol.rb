# frozen_string_literal: true

require "opengl"
require "glfw"

require_relative "parasol/version"

module Parasol
  class Error < StandardError; end
  # Your code goes here...
end

require_relative "parasol/opengl_context"
require_relative "parasol/program"
require_relative "parasol/shader"
require_relative "parasol/shader_error"
require_relative "parasol/fragment_shader"
require_relative "parasol/geometry_shader"
require_relative "parasol/vertex_shader"
