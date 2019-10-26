using Test

include("affine_cipher.jl")


# Tests adapted from `problem-specifications//canonical-data.json` @ v2.0.0

println("\n"^2, "-"^60, "\n"^3)

@testset "Encode yes." begin
    @test encode("yes", 5, 7) == "xbt"
end
println()

@testset "Encode no." begin
    @test encode("no", 15, 18) == "fu"
end
println()


@testset "Encode OMG." begin
    @test encode("OMG", 21, 3) == "lvz"
end
println()


@testset "Encode O M G." begin
    @test encode("O M G", 25, 47) == "hjp"
end
println()


@testset "Encode mindblowingly." begin
    @test encode("mindblowingly", 11, 15) == "rzcwa gnxzc dgt"
end
println()


@testset "Encode numbers." begin
    @test encode("Testing,1 2 3, testing", 3, 4) == "jqgjc rw123 jqgjc rw"
end
println()


@testset "Encode deep thought." begin
    @test encode("Truth is fiction.", 5, 17) == "iynia fdqfb ifje"
end
println()


@testset "Encode all the letters." begin
    @test encode("The quick brown fox jumps over the lazy dog.", 17, 33) ==
        "swxtj npvyk lruol iejdc blaxk swxmh qzglf"
end
println()


@testset "Encode raises meaningful exception." begin
    @test_throws DomainError encode("This is a test", 6, 17)
end
println()


@testset "Decode exercism." begin
    @test decode("tytgn fjr", 3, 7) == "exercism"
end
println()


@testset "Decode sentence." begin
    @test decode("qdwju nqcro muwhn odqun oppmd aunwd o", 19, 16) ==
        "anobstacleisoftenasteppingstone"
end
println()


@testset "Decode numbers." begin
    @test decode("odpoz ub123 odpoz ub", 25, 7) == "testing123testing"
end
println()


@testset "Decode all the letters." begin
    @test decode("swxtj npvyk lruol iejdc blaxk swxmh qzglf", 17, 33) ==
        "thequickbrownfoxjumpsoverthelazydog"
end
println()


@testset "Decode with no spaces." begin
    @test decode("swxtjnpvyklruoliejdcblaxkswxmhqzglf", 17, 33) ==
        "thequickbrownfoxjumpsoverthelazydog"
end
println()


@testset "Decode with too many spaces." begin
    @test decode("vszzm    cly   yd cg    qdp", 15, 16) == "jollygreengiant"
end
println()


@testset "Decode raises meaningful exception." begin
    @test_throws DomainError decode("Test", 13, 5)
end
println()
