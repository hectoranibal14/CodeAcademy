#Los items deben tener descripcion y precio.

class Item
    attr_reader :items
    def initialize
        #{codigo: [descripcion,precio]}
        @items = {100=>["Lapiz negro", 10], 101=>["Lapiz color", 15], 102=>["Goma de borrar", 20]}
    end
end