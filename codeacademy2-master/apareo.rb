#Teniendo 2 arrays de igual tamaño, 
#crear un hash donde los valores de un array sean las keys y el otro array sean los valores.

vector1 = ['a', 'b', 'c', 'd']
vector2 = [1, 2, 3, 4]

class Apareo 

    def initialize (vector1, vector2)
        if vector1.length == vector2.length
            @vector1 = vector1
            @vector2 = vector2
            @hash_apareo = {}
        else
            puts "Los vectores no son de igual tamaño"
        end
    end

    def apareo_vectores
        @vector1.each_with_index do |valor,indice|
        @hash_apareo[valor] = @vector2[indice]
        end
        @hash_apareo
    end

end

variable = Apareo.new(['a', 'b', 'c', 'd'],[1, 2, 3, 4])
variable.apareo_vectores