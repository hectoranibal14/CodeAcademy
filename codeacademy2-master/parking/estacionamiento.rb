require_relative 'auto.rb'

class Estacionamiento
    attr_reader :patente, :marca, :capacidad

    def initialize (capacidad)
        @capacidad = capacidad
        @autos_estacionados = []
        @historial_por_patente = {}
        @historial_por_marca = {}

    end 

    def entrada_estacionamiento (autito)
        if autito.class
            @autos_estacionados.push autito
            actualizar_historial(autito)
        end
        
    end

    def actualizar_historial(autito)
        if @historial_por_patente.has_key?(autito.patente)    
            @historial_por_patente[autito.patente] = @historial_por_patente[autito.patente] + 1
        else 
            @historial_por_patente[autito.patente] = 1
        end

        if @historial_por_marca.has_key?(autito.marca)
            @historial_por_marca[autito.marca] = @historial_por_patente[autito.marca] + 1
        else
            @historial_por_marca[autito.marca] = 1
        end  
    end
    
    #Poder consultar la cantidad de lugares ocupados actualmente.
    def consulta_lugares_ocupados    
        @autos_estacionados.size
    end

    #Poder consultar la cantidad de lugares libres actualmente.
    def consulta_lugares_libres
        @capacidad - @autos_estacionados.size
    end

    #Poder registrar el egreso de un auto del estacionamiento.
    def registrar_egreso (autito)
        @autos_estacionados.delete(autito)
    end

    #Poder consultar el porcentaje de ocupación actual.
    def porcentaje_ocupacion
        porcentaje_ocupacion = (@autos_estacionados.size.to_f/@capacidad.to_f)*100
    end

    #Poder consultar si el estacionamiento se encuentra lleno.
    def consulta_esta_lleno
        @capacidad == @autos_estacionados.size
    end

    #Poder consultar mediante la patente, cuántas veces ingresó al estacionamiento un determinado auto.
    def consultar_por_patente(autito)
        @historial_por_patente[autito.patente]
    end

    #Poder consultar cuántas veces ingresaron autos de una determinada marca.
    def consultar_por_marca(autito)
        @historial_por_marca[autito.marca]
    end

    #Poder consultar las patentes de los autos que ingresaron al menos un X número de veces 
    #(sólo una lista con las patentes, sin las cantidades de cada uno).
    def consultar_por_patente_X_veces(x_veces)
        @historial_por_patente.select {|patente,cantidad| cantidad >= x_veces}.keys
    end

    #Poder consultar el top 3 de marcas que tuvieron más autos ingresados. 
    #Devolver un hash mostrando la marca y la cantidad, ordenado por cantidad de mayor a menor 
    #y asegurándose que la marca se muestre capitalizada (primera letra en mayúscula y el resto en minúscula).
    def consultar_top_3_marcas(top)
        historial_ordenado = Hash[@historial_por_marca.sort_by {|marca, cantidad| -(cantidad)}.first(top)]
        historial_ordenado.map {|marca,cantidad| marca.capitalize}
    end
end 
