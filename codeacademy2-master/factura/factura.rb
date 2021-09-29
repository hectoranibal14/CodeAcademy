require_relative 'item.rb'

class Factura
    attr_reader :items

    def initialize (numero)
        @fecha = Time.now
        @numero_factura = numero
        @articulo = Item.new
        @nueva_factura = {} #{codigo => [descripcion, cantidad_x_item]}
    end

    def agregar_item(codigo, cantidad)
        if !@nueva_factura.has_key? (codigo)
            @nueva_factura[codigo] = [@articulo.items[codigo][0],cantidad]
        else
            @nueva_factura[codigo][1] = @nueva_factura[codigo][1] + cantidad
        end
        @nueva_factura
    end

    def eliminar_item(codigo,cantidad)
        if @nueva_factura[codigo][1] == cantidad
            @nueva_factura.delete(codigo)
        else
            if @nueva_factura[codigo][1] > cantidad
                @nueva_factura[codigo][1] = @nueva_factura[codigo][1] - cantidad
            end
        end
    end

    def array_con_descripcion
        array_descripcion = []
        @nueva_factura.each do |codigo, vector|
            array_descripcion.push (@articulo.items[codigo][0])
        end
        array_descripcion
    end

    def calcular_total
        @total = 0
        @nueva_factura.each do |codigo, vector|
            @total = @total + @nueva_factura[codigo][1]*@articulo.items[codigo][1]
        end
        @total
    end

    def factura_final
        {@numero_factura => [@fecha.strftime("%d/%m/%Y - %k:%M"),@total]}
    end

end