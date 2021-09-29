class Contador
    def initialize
        @valor = 15
    end

    def valorActual
        puts "El valor actual es #{@valor}"
    end

    def incrementar
        @valor + 1
    end

    def decrementar
        @valor - 1
    end

    def incremetarEnX (numero)
        @numero = numero
        @valor + @numero
    end

    def decrementarEnX (numero)
        @numero = numero
        @valor - @numero
    end

    def asignarValor (numero)
        @valor = numero
    end
end

