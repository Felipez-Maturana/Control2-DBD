-- 1
CREATE VIEW uv2 AS SELECT anuncios.id_usuario FROM visitas2, anuncios WHERE visitas2.id_usuario = anuncios.id_usuario AND visitas2.id_anuncios = anuncios.id_anuncios;
SELECT id_usuario FROM usuarios LEFT JOIN uv2 ON usuarios.id_usuario = uv2.id_usuario WHERE uv2.id_usuario IS NULL;

-- 2
CREATE VIEW usuarioAnuncios AS SELECT anuncios.id_usuario, count(*) FROM anuncios WHERE MONTH(anuncios.fecha)=5 GROUP BY anuncios.id_usuario
create view anunciosmaximo AS SELECT MAX(usuarioanuncios.NUMEROANUNCIOS) AS maximo FROM usuarioanuncios
SELECT id_usuario FROM usuarioanuncios,anunciossmaximo WHERE usuarioanuncios.NUMEROANUNCIOS = anunciossmaximo.maximo

-- 3
CREATE VIEW publicaciones30Abril AS SELECT id_anuncio FROM anuncios WHERE MONTH(anuncios.fecha) = 4 && day(anuncios.fecha)=30
Create view ComentariosPorUser  AS SELECT comentarios.id_usuario , COUNT(*) AS anuncioscomentados30Abril From comentarios, publicaciones30abril Where comentarios.id_anuncio = publicaciones30abril.id_anuncio GROUP BY id_usuario
SELECT id_usuario FROM ComentariosPorUser WHERE ComentariosPorUser.anuncioscomentados30Abril =(SELECT MAX(anuncioscomentados30Abril
) FROM  ComentariosPorUser)

-- 4
SELECT id_usuario,id_anuncio,sum(visitas) from anuncios GROUP BY id_usuario

-- 5
SELECT texto from anuncios ORDER BY visitas DESC

