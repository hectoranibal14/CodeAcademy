class Comparador
    def initialize (numero1, numero2)
        @numero1 = numero1
        @numero2 = numero2
    end

    def comparar
        valor = if (@numero1 == @numero2)
            @numero1 * @numero2
        elsif (@numero1 < @numero2)
            @numero1 - @numero2
        else
            @numero1 + @numero2
        end
        
        puts "Resultado: #{valor}"
    end 
end


if (@numero1 == @numero2)
    @numero1 * @numero2
elsif (@numero1 < @numero2)
    @numero1 - @numero2
else
    @numero1 + @numero2
end
