class Contador
    attr_reader :valor, :cantidad_operaciones

    def initialize(valor)
        @valor = valor
        @cantidad_operaciones = 0
    end

    def valorActual
        @valor
    end

    def incrementar
        @cantidad_operaciones += 1
        @valor += 1
    end

    def decrementar
        @cantidad_operaciones += 1
        @valor -= 1
    end

    def incrementarEnX (numero)
        @cantidad_operaciones += 1
        @numero = numero
        @valor += @numero
    end

    def decrementarEnX (numero)
        @cantidad_operaciones += 1
        @numero = numero
        @valor -= @numero
    end

end

