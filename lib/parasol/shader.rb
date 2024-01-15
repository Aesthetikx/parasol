# frozen_string_literal: true

module Parasol
  class Shader
    include OpenGLContext

    attr_reader :source, :type

    def initialize source:, type:
      @source = source
      @type = type
    end

    def handle
      the_shader || compile_the_shader!
    end

    def delete
      cleanup
    end

    def compiled?
      !the_shader.nil?
    end

    private

    LOG_SIZE = 8192

    attr_reader :the_shader

    def compile_the_shader!
      if compiled?
        return the_shader # : Integer
      end

      require_opengl_context!

      @the_shader = create_shader!

      compile_shader!
    end

    def create_shader!
      GL.CreateShader(type).tap do |pointer|
        fail Parasol::ShaderError, "Unable to create shader." if pointer.zero?
      end
    end

    def compile_shader!
      GL.ShaderSource the_shader, 1, packed_source, nil

      GL.CompileShader the_shader

      if compiled_successfully?
        return the_shader # : Integer
      end

      message = last_error_message

      fail Parasol::ShaderError, "Unable to compile shader:\n#{message}"
    rescue Parasol::ShaderError
      cleanup

      raise
    end

    def compiled_successfully?
      compile_status == GL::TRUE
    end

    def packed_source
      [source].pack "p"
    end

    def compile_status
      status_buffer = " " * 4

      GL.GetShaderiv the_shader, GL::COMPILE_STATUS, status_buffer

      status = status_buffer.unpack1 "L"

      status&.to_i
    end

    def last_error_message
      length_buffer = " " * 4
      log_buffer = " " * LOG_SIZE

      GL.GetShaderInfoLog the_shader, LOG_SIZE, length_buffer, log_buffer

      log_buffer.strip
    end

    def cleanup
      return unless compiled?

      require_opengl_context!

      GL.DeleteShader the_shader
    ensure
      @the_shader = nil
    end
  end
end
