#hash donde se tiene como key el nombre de un pais y como Value a su capital
paises = {'Argentina': 'CABA', 'Uruguay': 'Montevideo', 'Chile': 'Santiago', 'Brasil': 'Brasilia', 'Estados Unidos': 'Washington'}

def  initialize (paises)
    @paises = paises
end

def mostrar(newKey)
    @paises.each {|key,valor| puts valor if key == :newKey}
end

#Listar todas las capitales de paises que comiencen con "B"
paises.each do |key,valor|
    if key[0] == "B"
        puts valor
    end 
end
#en una sola linea:
paises.each {|key,valor| puts dato if key[0] == "B"}

#metodo
def capital_empieza_letra (letra)
    paises.each {|key,valor| puts dato if key[0] == letra} #ver downcase, slize ó star_with
end

#Listar los paises que tengan capitales que terminen con "a"
paises.each do |key,dato|
    if dato[-1] == "a"
        puts key
    end
end

#en una sola linea:
paises.each {|key,dato| puts key if dato[-1] == "a"}

#metodo
def capital_termina_letra (letra)
    paises.each {|key,dato| puts key if dato[-1] == letra}
end

#Listar los paises que tengan capitales con nombres mayor a 8 caracteres
paises.each do |key,dato|
    if dato.length > 8
        puts key
    end
end

#en una sola linea:
paises.each {|key,dato| puts key if dato.length > 8}


class Pais

    def  initialize (paises)
        @paises = paises
    end
    
    def mostrar(newKey)
        @paises.each {|key,valor| puts valor if key.eql? (newKey)}
    end
    
    #metodo
    def capital_empieza_letra (letra)
        @paises.each {|key,valor| puts valor if key[0].downcase == letra.downcase}
    end
    
    #metodo
    def capital_termina_letra (letra)
        @paises.each {|key,valor| puts key if valor[-1] == letra}
    end
    
    #metodo
    def capital_nombre_mayor (numero)
        @paises.each {|key,valor| puts key if valor.length > numero}
    end
    
end
    
mi_pais = Pais.new ({'Argentina': 'CABA', 'Uruguay': 'Montevideo', 'Chile': 'Santiago', 'Brasil': 'Brasilia'})