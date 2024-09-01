# frozen_string_literal: true

RSpec.describe Parasol::Shader do
  context "with an OpenGL context" do
    include_context "with an OpenGL context"

    describe "compiling" do
      it "compiles a simple fragment shader" do
        source = File.read "spec/fixtures/simple.fragment"

        shader = Parasol::FragmentShader.new(source:)

        expect(shader.handle).not_to be_zero
      end

      it "compiles a simple vertex shader" do
        source = File.read "spec/fixtures/simple.vertex"

        shader = Parasol::VertexShader.new(source:)

        expect(shader.handle).not_to be_zero
      end

      it "compiles a simple geometry shader" do
        source = File.read "spec/fixtures/simple.geometry"

        shader = Parasol::GeometryShader.new(source:)

        expect(shader.handle).not_to be_zero
      end

      it "reports syntax errors" do
        source = File.read "spec/fixtures/syntax_error.fragment"

        shader = Parasol::FragmentShader.new(source:)

        expect { shader.handle }.to \
          raise_error(Parasol::ShaderError)
          .with_message(/xyzzy/i)
      end
    end

    describe "deleting" do
      it "deletes a shader" do
        source = File.read "spec/fixtures/simple.fragment"

        shader = Parasol::FragmentShader.new(source:)

        shader.handle

        expect { shader.delete }.to \
          change { shader.compiled? }.from(true).to(false)
      end
    end
  end

  context "without an OpenGL context" do
    it "raises a shader error" do
      source = File.read "spec/fixtures/simple.fragment"

      shader = Parasol::FragmentShader.new(source:)

      expect { shader.handle }.to \
        raise_error(Parasol::ShaderError)
        .with_message(/no OpenGL context/i)
    end
  end
end
