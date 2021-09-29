#3 - Crear un metodo al cual se le pase una frase y 
#devuela un hash con las vocales incluidas en dicha frase y la frecuencia de aparicion de cada una de ellas.
class Vocales

    def initialize (frase)
        @frase = frase
    end

    def contar_vocales 
        hash_vocales = {}   
        vocales = ['a', 'e', 'i', 'o', 'u']
        vocales.each {|vocal| hash_vocales[vocal] = @frase.count vocal}

        hash_vocales
 
    end

end
