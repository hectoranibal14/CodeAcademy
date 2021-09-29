#Teniendo un hash donde se tengan como key los apellidos de los alumnos y como values las notas de tres parciales,
#se busca:
#a) Qué alumnos se sacaron más de 7 en todos los parciales.
#b) Qué alumnos se sacaron menos de 4 en todos los parciales.
#c) Cuántos alumnos se sacaron más de 7 en al menos dos parciales.
#d) El/los alumno/s con mejor promedio.
#e) El/los alumno/s con peor promedio.

#hash_alumnos = {:'apellido', notas}
#notas = [nota1,nota2,nota3]
#recorrer el hash por key y dentro recorrer vector notas y procesar

class Alumno
    def initialize (hash)
        @hash_alumnos = hash
        @hash_promedios = {}
    end

    #a) Qué alumnos se sacaron más de 7 en todos los parciales.
    def alumnos_aprobaron_todo (nota_aprobar)
        alumnos_aprobados = []
        @hash_alumnos.each do |apellido, notas| 
            alumnos_aprobados.push apellido if notas.all? {|a| a >= nota_aprobar}
        end
        alumnos_aprobados
    end

    #b) Qué alumnos se sacaron menos de 4 en todos los parciales.
    def alumnos_no_aprobaron (nota_menor)
        alumnos_no_aprobados = []
        @hash_alumnos.each do |apellido, notas|
            alumnos_no_aprobados.push apellido if notas.all? {|a| a < nota_menor}
        end
        alumnos_no_aprobados
    end

    #c) Cuántos alumnos se sacaron más de 7 en al menos dos parciales.
    def alumnos_aprobaron_dos(nota_parcial)
        cantidad = 0
        @hash_alumnos.each do |apellido, notas|
            cont = 0
            notas.each do |nota|
                if nota >= nota_parcial
                    cont = cont + 1
                end
            end
            if cont >= 2
                cantidad = cantidad + 1
            end
        end
        cantidad
    end

    #calula promedios
    def calcular_promedios
        @hash_alumnos.each do |apellido, notas|
            @hash_promedios[apellido] = notas.sum/notas.size
        end
        @hash_promedios
    end

    #d) El/los alumno/s con mejor promedio.
    def mejor_promedio
        @hash_promedios.each do |apellido, promedio|
            puts "Nombre: #{apellido}" if promedio == @hash_promedios.values.max
        end
    end
    
    #e) El/los alumno/s con peor promedio.
    def peor_promedio
        @hash_promedios.each do |apellido, promedio|
            puts "Nombre: #{apellido}" if promedio == @hash_promedios.values.min
        end
    end

end


clase_alumnos = Alumno.new({"Ab"=>[6,7,8], "Bc"=>[7,8,9], "Cd"=>[8,9,10], "De"=>[4,5,6], "Ef"=>[5,6,7], "Fg"=>[2,3,4], "Gh"=>[1,2,3]})
clase_alumnos.alumnos_aprobaron_todo(7)
clase_alumnos.alumnos_no_aprobaron(4)
clase_alumnos.alumnos_aprobaron_dos(7)
clase_alumnos.calcular_promedios
clase_alumnos.mejor_promedio
clase_alumnos.peor_promedio

