#Crear una clase Abreviador

#La clase tiene que tener un método "abreviar" que toma una palabra y la abrevia.
#La clase se debe poder manejar por defecto las abreviaturas "Señor" => "Sr.", "Señora" => "Sra." y "Señore" => "Sre."
#La clase tiene que tener metodos para:
#Agregar una abreviatura
#Eliminar una abreviatura
#Listar todas las abreviaturas.
#Usando una segunda clase que almacene la cantidad de usos de cada abreviatura

#Agregar un metodo que liste la o las abreviatura más utilizadas.
#Agregar un método que liste todas las abreviaturas que nunca se usaron.

require_relative 'almacenamiento.rb'

class Abreviador
    attr_reader :almacenamiento, :almacen

    def initialize
        @almacen = Almacen.new
    end
    
    def abreviar(palabra)
        if @almacen.palabras_abreviaturas.has_key?(palabra)
            #@almacen.cantidad_usos[abreviatura] = @almacen.cantidad_usos[abreviatura] + 1     
            abreviada = @almacen.palabras_abreviaturas[palabra]
            @almacen.cantidad_usos[abreviada] = @almacen.cantidad_usos[abreviada] + 1     
            abreviada
        end
    end

    def agregar_abreviatura(palabra,abreviatura)
        if !@almacen.palabras_abreviaturas.has_key?(palabra)
            @almacen.palabras_abreviaturas[palabra] = abreviatura
            @almacen.cantidad_usos[abreviatura] = 0
        end
    end

    def eliminar_abreviatura(palabra_a_borrar)
        @almacen.palabras_abreviaturas.delete (palabra_a_borrar)
    end

    def listar_abreviaturas
        @almacen.palabras_abreviaturas
    end

    def listar_mas_utilizadas(top)
        Hash[@almacen.cantidad_usos.sort_by {|abreviatura, cantidad| -(cantidad)}.first(top)]
    end

    def listar_no_usadas
        Hash[@almacen.cantidad_usos.select {|abreviatura,cantidad| cantidad == 0}]
    end

end