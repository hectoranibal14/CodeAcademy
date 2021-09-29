Teniendo un array de numeros enteros. Devolver un hash con las siguientes keys:
1) 'maximo'
2) 'minimo'
3) 'average'
4) 'numeros_mayores_al_promedio' --> Array

vector = [1,2,3,4,5,6,7,8,9,10,11,12]
nuevoVector = []
vector.each do |valor|
    if valor <= hash[:average]
        nuevoVector.push valor
    end
end
hash = {maximo: vector.max, minimo: vector.min, average: vector.sum/vector.size, array: nuevoVector}


hash = {}


