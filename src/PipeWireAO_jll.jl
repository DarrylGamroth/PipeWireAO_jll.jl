# Use baremodule to shave off a few KB from the serialized `.ji` file
baremodule PipeWireAO_jll
using Base
using Base: UUID
Base.include(@__MODULE__, joinpath("..", ".pkg", "platform_augmentation.jl"))
import JLLWrappers

JLLWrappers.@generate_main_file_header("PipeWireAO")
JLLWrappers.@generate_main_file("PipeWireAO", Base.UUID("cde84cf6-9a21-5ce0-b5e3-1526e778c30b"))
end  # module PipeWireAO_jll
