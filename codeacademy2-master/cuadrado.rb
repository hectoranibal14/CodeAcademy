class Cuadrado
    def initialize (lado)
        @lado = lado
        if (@lado <= 0)
            puts "Es cualquiera"
        end
    end

    def superficie
        @lado * @lado
    end

    def perimetro
        @lado * 4
    end
end


#otra forma
def initialize (lado)
    unless lado <= 0
        @lado = lado
    else
        puts "Es cualquiera"
    end
end

#otra forma
def initialize (lado)
    puts "Es cualquiera" if lado <= 0
    @lado = lado
    end
end

#otra forma
def initialize (lado)
    puts "Es cualquiera" unless lado > 0
    @lado = lado
    end
end

