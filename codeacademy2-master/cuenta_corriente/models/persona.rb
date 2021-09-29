require_relative 'cuenta.rb'
require 'byebug'

class Persona
    def initialize (dni, nombre, apellido)
        @dni = dni
        @nombre = nombre
        @apellido = apellido
        @cuentas = []
    end

    def agregar_cuenta(monto, id_cuenta)
        @cuentas.push (Cuenta_corriente.new(monto,id_cuenta)) if @cuentas.length < 3
    end

    def eliminar_cuenta(id_cuenta)
        @cuentas.each {|cuenta| @cuentas.delete(cuenta) if cuenta.id_cuenta == id_cuenta}
    end

    def consulta_estado
        @estado = @cuentas.all? {|cuentas| cuentas.saldo > 0}
    end
end




