function encode(plain_text::String, a::Int, b::Int)
    letters = "abcdefghijklmnopqrstuvwxyz"
    if gcd(a, length(letters)) != 1
        throw(DomainError("a and b are not coprime."))
    end
    num = Dict()
    i = 0
    for letter in letters
        num[letter] = i
        i += 1
    end


    encrypted = ""
    cnt = 0
    for char in plain_text
        if lowercase(char) in letters
            if cnt > 0  &&  cnt % 5 == 0
                encrypted *= ' '
            end
            num_enc = (a*num[lowercase(char)] + b) % length(letters)
            encrypted *= letters[num_enc + 1]
            cnt += 1
        elseif lowercase(char) in letters  ||  isnumeric(char)
            encrypted *= char
            cnt += 1
        end
    end

    encrypted # returned
end

function decode(ciphered_text::String, a::Int, b::Int)
    letters = "abcdefghijklmnopqrstuvwxyz"
    if gcd(a, length(letters)) != 1
        throw(DomainError("a and b are not coprime."))
    end
    num = Dict()
    i = 0
    for letter in letters
        num[letter] = i
        i += 1
    end


    decrypted = ""
    a⁻¹ = modulo_multiplicative_inverse(a, length(letters))
    for char in ciphered_text
        if char in letters
            num_dec = a⁻¹ * (num[lowercase(char)] - b) % length(letters)
            # In Julia % is the remainder operator, whereas in Python it is the modulus
            # In Julia -17 % 100 is -17, whears in Python -17 % 100 is 83
            # https://docs.julialang.org/en/v1/manual/noteworthy-differences/#Noteworthy-differences-from-Python-1
            if num_dec < 0;    num_dec += length(letters);    end

            decrypted *= letters[num_dec + 1]
        elseif char != ' '
            decrypted *= char
        end
    end

    decrypted # returned
end

function modulo_multiplicative_inverse(a, m)
# Assumes that A and M are co-prime

    # Find gcd using Extended Euclid's Algorithm
    gcd, x, y = extended_euclid_gcd(a, m)
    if x < 0;    x += m;    end

    return x
end


function extended_euclid_gcd(a, b)

    s = 0;    sₚ = 1
    t = 1;    tₚ = 0
    r = b;    rₚ = a

    while r != 0
        q = rₚ ÷ r # quotient

        rₚ, r  =  r, rₚ - q*r
        sₚ, s  =  s, sₚ - q*s
        tₚ, t  =  t, tₚ - q*t
    end

    return [rₚ, sₚ, tₚ]
end
