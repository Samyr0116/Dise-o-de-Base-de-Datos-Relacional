-- 1.Obtener todos los libros disponibles (que no están actualmente prestados).
SELECT l.id, l.titulo FROM Libro l
LEFT JOIN Prestamo p ON
l.id = p.id_libro
WHERE l.id NOT IN (SELECT id_libro FROM Prestamo);

-- 2.Encontrar todos los préstamos realizados por un usuario específico.
SELECT * FROM Prestamo p
JOIN Usuario u ON
u.id = p.id_usuario
WHERE id_usuario=1;

-- 3.Calcular la cantidad total de préstamos realizados por cada usuario.
SELECT u.primer_nombre, COUNT(p.id) As cantidad_prestamo
FROM Usuario u 
INNER JOIN Prestamo p ON u.id = p.id_usuario
GROUP BY u.primer_nombre;

-- 4.Obtener todos los libros y ordenarlos de forma descendente según la cantidad de veces que han sido prestados.
SELECT l.titulo, COUNT(p.id_libro) As candtidad_libro FROM Libro l 
INNER JOIN Prestamo p ON l.id = p.id_libro
GROUP BY l.titulo
ORDER BY candtidad_libro desc;

-- 5.Calcular el promedio de días de duración de los préstamos.
SELECT AVG(duracion_del_prestamo) AS promedio_duracion_en_dias FROM Prestamo

-- 6.Obtener todos los libros y calcular la cantidad promedio de días que permanecen prestados.
SELECT l.titulo, AVG(duracion_del_prestamo) AS promedio_duracion_en_dias FROM Libro l 
INNER JOIN Prestamo p ON l.id = p.id_libro
GROUP BY l.titulo
ORDER BY promedio_duracion_en_dias desc;

-- 7.Encontrar al usuario que ha realizado la mayor cantidad de préstamos.
SELECT TOP 4 u.primer_nombre, COUNT(p.id) As cantidad_prestamo
FROM Usuario u 
INNER JOIN Prestamo p ON u.id = p.id_usuario
GROUP BY u.primer_nombre
ORDER BY cantidad_prestamo desc;

-- 8.Encontrar los libros que nunca han sido prestados.
SELECT l.id, l.titulo FROM Libro l
LEFT JOIN Prestamo p ON
l.id = p.id_libro
WHERE l.id != ALL (SELECT id_libro FROM Prestamo);

-- 9.Obtener los usuarios que solo han realizado un préstamo.
SELECT u.primer_nombre, COUNT(p.id)
FROM Usuario u 
INNER JOIN Prestamo p ON u.id = p.id_usuario
GROUP BY u.primer_nombre
HAVING COUNT(p.id) = 1
