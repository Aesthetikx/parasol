# frozen_string_literal: true

# Initialize an OpenGL context, which is required for shader compilation.
RSpec.shared_context "with an OpenGL context" do
  before :all do
    initialize_opengl
    initialize_glfw
    setup_context
  end

  after :all do
    teardown_context
  end

  private

  def initialize_opengl
    GL.load_lib
  end

  def initialize_glfw
    GLFW.load_lib
    GLFW.Init

    GLFW.WindowHint GLFW::GLFW_CONTEXT_VERSION_MAJOR, 3
    GLFW.WindowHint GLFW::GLFW_CONTEXT_VERSION_MINOR, 3
    GLFW.WindowHint GLFW::GLFW_OPENGL_PROFILE, GLFW::GLFW_OPENGL_CORE_PROFILE
  end

  def setup_context
    GLFW.WindowHint GLFW::GLFW_VISIBLE, GLFW::GLFW_FALSE

    window = GLFW.CreateWindow 256, 256, "Test Context", nil, nil

    GLFW.MakeContextCurrent window
  end

  def teardown_context
    GLFW.DestroyWindow GLFW.GetCurrentContext
    GLFW.Terminate
  end
end
