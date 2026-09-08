using Base.BinaryPlatforms: arch, arch_march_isa_mapping, CPUID, HostPlatform, Platform

function augment_microarchitecture!(platform::Platform)
    haskey(platform, "march") && return platform

    host_arch = arch(HostPlatform())
    host_isas = arch_march_isa_mapping[host_arch]
    idx = findlast(((name, isa),) -> isa <= CPUID.cpu_isa(), host_isas)
    platform["march"] = first(host_isas[idx])
    return platform
end

function augment_platform!(platform::Platform)
    @static if Sys.ARCH === :x86_64
        augment_microarchitecture!(platform)
        # Julia recognizes an intermediate AVX tier, but this package does
        # not publish a distinct AVX artifact. Select the baseline artifact
        # instead of falling through to the untagged compatibility entry.
        platform["march"] == "avx" && (platform["march"] = "x86_64")
    end
    return platform
end
