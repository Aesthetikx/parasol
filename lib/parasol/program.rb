# frozen_string_literal: true

module Parasol
  class Program
    include OpenGLContext

    attr_reader :shaders

    def initialize shaders:
      @shaders = shaders
    end

    def handle
      the_program || create_the_program!
    end

    def delete
      cleanup
    end

    def linked?
      !the_program.nil?
    end

    private

    attr_reader :the_program

    def create_the_program!
      if linked?
        return the_program # : Integer
      end

      require_opengl_context!

      @the_program = create_program!

      link_program!
    end

    def create_program!
      GL.CreateProgram.tap do |pointer|
        fail Parasol::ShaderError, "Unable to create program" if pointer.zero?
      end
    end

    def link_program!
      fail Parasol::ShaderError, "Program has not been created" unless the_program

      attach_shaders

      GL.LinkProgram the_program

      if linked_successfully?
        return the_program # : Integer
      end

      message = last_error_message

      fail Parasol::ShaderError, "Unable to compile program:\n#{message}"
    rescue Parasol::ShaderError
      cleanup

      raise
    end

    def attach_shaders
      return unless the_program

      shaders.each do |shader|
        GL.AttachShader the_program, shader.handle
      end
    end

    def link_status
      return unless the_program

      status_buffer = " " * 4

      GL.GetProgramiv the_program, GL::LINK_STATUS, status_buffer

      status = status_buffer.unpack1 "L"

      status&.to_i
    end

    def linked_successfully?
      link_status == GL::TRUE
    end

    def last_error_message
      return unless the_program

      log_size = 8192
      length_buffer = " " * 4
      log_buffer = " " * log_size

      GL.GetProgramInfoLog the_program, log_size, length_buffer, log_buffer

      log_buffer.strip
    end

    def cleanup
      return unless the_program

      require_opengl_context!

      GL.DeleteProgram the_program

      shaders.each(&:delete)
    ensure
      @the_program = nil
    end
  end
end
