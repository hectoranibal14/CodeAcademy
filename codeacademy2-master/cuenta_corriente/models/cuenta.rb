class Cuenta_corriente
	attr_reader :saldo, :id_cuenta

	def initialize(id_cuenta)
		@saldo = 0
		@id_cuenta = id_cuenta
	end

	def consultar_saldo
		@saldo
	end
	
	def consultar_id
		@id_cuenta
	end

	def acreditar (monto)
		@saldo += monto
	end

	def debitar(monto)
		@saldo = if (@saldo >= monto)
			@saldo -= monto
		else
			@saldo
		end
	end
end
