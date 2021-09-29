# Ingresar n números enteros en un array, calcular el promedio entero y reemplazar todos los números que ocupan las posiciones pares, por el promedio calculado.

vector = [1,2,3,4,5,6,7,8,9,10]
promedio = vector.sum/vector.size
vector.each_with_index do |valor,index|
    vector[index] = promedio if index.even?
end


# Ingresar n números enteros en un array, calcular el promedio entero y luego reemplazar el mayor número del array por el promedio calculado.

vector = [1,2,3,4,5,6,7,8,9,10]
promedio = vector.sum/vector.size
vector.each_with_index do |valor,index|
    vector[index] = promedio if (valor == vector.max)
end


# Ingresar n números enteros en un array, luego ingresar un número, 
# si el número ingresado se encuentra dentro del array, que muestre su posición, 
# caso contrario mostrar el mensaje: “El número no está en el array”.

vector = [1,5,3,4,5,5,7,5,9,10]
puts "Ingrese un numero"
numero = gets.chomp
cont = 0
vector.each.with_index do |valor,index|
    if (valor == numero)
        puts "#{index}"
        cont = cont + 1
    end
end
puts "El numero no esta" if cont == 0


# Ingresar n números enteros en un array, luego ingresar un número cualquiera y 
#crear un nuevo array con todos los números menores e iguales al número que se ingresó. 
#En caso de que no exista ninguno, mostrar un mensaje correspondiente.

vector = [2,3,4,5,6,7,8,9,10]
numero = 1
nuevoVector=[]
contador = 0
vector.each do |valor|
    if valor <= numero
        nuevoVector.push valor
        contador += 1
    end
end
puts "no existe ninguno" if contador == 0


# En un concurso de conocimiento se almacena en un array los nombres de N participantes 
#y en otro array las notas obtenidas (valores de 0 a 10), 
#se pide mostrar el nombre del participante que obtuvo la mayor nota.

nombres = ["a","b","c","d"]
notas = [6,7,8,9]
notas.each_with_index do |valor,index|
    if valor == notas.max
        puts nombres[index]
        puts notas[index]
    end
end
