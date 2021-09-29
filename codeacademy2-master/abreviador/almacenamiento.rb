#Usando una segunda clase que almacene la cantidad de usos de cada abreviatura

class Almacen
    attr_reader :palabras_abreviaturas, :cantidad_usos
    def initialize
        @palabras_abreviaturas = {"Señor"=>"Sr.", "Señora"=>"Sra.", "Señore"=>"Sre."}
        @cantidad_usos = {"Sr."=>0, "Sra."=>0, "Sre."=>0}
    end
end
