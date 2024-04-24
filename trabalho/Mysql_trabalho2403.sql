CREATE DATABASE Escolinha;
 
drop database Escolinha;
 
USE Escolinha;
 
CREATE TABLE professores (
	professor_id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255)
);
 
CREATE TABLE turmas (
	turma_id INT PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(255)
);
 
CREATE TABLE alunos (
	aluno_id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255),
    idade INT,
    turma_id INT,
	FOREIGN KEY (turma_id) REFERENCES turmas(turma_id)
);
 
CREATE TABLE atividades (
	atividade_id INT PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(255),
    turma_id INT,
    FOREIGN KEY (turma_id) REFERENCES turmas(turma_id)
);
 
CREATE TABLE notas (
	atividade_id INT,
    aluno_id INT,
	FOREIGN KEY (aluno_id) REFERENCES alunos(aluno_id),
    FOREIGN KEY (atividade_id) REFERENCES atividades(atividade_id),
    nota DECIMAL(5,2)
);
 
CREATE TABLE turma_professor (
	turma_id INT,
    professor_id INT,
	FOREIGN KEY (turma_id) REFERENCES turmas(turma_id),
    FOREIGN KEY (professor_id) REFERENCES professores(professor_id)
);
 
-- Inserção de dados nas Turmas
INSERT INTO Turmas (turma_id, descricao) VALUES (1, 'Matemática 101');
INSERT INTO Turmas (turma_id, descricao) VALUES (2, 'História 101');
INSERT INTO Turmas (turma_id, descricao) VALUES (3, 'Ciências 101');
 
-- Inserção de dados nos Professores
INSERT INTO Professores (professor_id, nome) VALUES (1, 'Carlos Silva');
INSERT INTO Professores (professor_id, nome) VALUES (2, 'Maria Fernandes');
INSERT INTO Professores (professor_id, nome) VALUES (3, 'João Pereira');
 
-- Inserção de dados na tabela Turma_Professor
INSERT INTO Turma_Professor (turma_id, professor_id) VALUES (1, 1);
INSERT INTO Turma_Professor (turma_id, professor_id) VALUES (2, 2);
INSERT INTO Turma_Professor (turma_id, professor_id) VALUES (3, 3);
 
-- Inserção de dados nos Alunos
INSERT INTO Alunos (aluno_id, nome, idade, turma_id) VALUES (1, 'Ana Santos', 15, 1);
INSERT INTO Alunos (aluno_id, nome, idade, turma_id) VALUES (2, 'Pedro Gonçalves', 16, 1);
INSERT INTO Alunos (aluno_id, nome, idade, turma_id) VALUES (3, 'Lucas Andrade', 15, 2);
INSERT INTO Alunos (aluno_id, nome, idade, turma_id) VALUES (4, 'Mariana Costa', 16, 3);
 
-- Inserção de dados nas Atividades
INSERT INTO Atividades (atividade_id, descricao, turma_id) VALUES (1, 'Prova de Matemática', 1);
INSERT INTO Atividades (atividade_id, descricao, turma_id) VALUES (2, 'Trabalho de História', 2);
INSERT INTO Atividades (atividade_id, descricao, turma_id) VALUES (3, 'Experimento de Ciências', 3);
 
-- Inserção de dados nas Notas
INSERT INTO Notas (aluno_id, atividade_id, nota) VALUES (1, 1, 9.5);
INSERT INTO Notas (atividade_id, nota) VALUES (1, 8.0);
INSERT INTO Notas (aluno_id, atividade_id, nota) VALUES (3, 2, 7.5);
 
 
-- Listando nome de todos alunos e suas turmas
SELECT alunos.nome AS Nome_Aluno, turmas.descricao AS Turma
FROM alunos
INNER JOIN turmas ON alunos.turma_id = turmas.turma_id;
 
-- Listando os alunos com suas notas na primeira atividade 
SELECT alunos.nome AS Alunos, notas.nota AS Notas
FROM alunos
LEFT JOIN notas ON alunos.aluno_id = notas.aluno_id AND notas.atividades_id = 1;
 
-- Listando as notas e o nome dos alunos
SELECT alunos.nome AS Nome_Aluno, notas.nota AS Nota
FROM alunos
RIGHT JOIN notas ON alunos.aluno_id = notas.aluno_id;
 
SELECT alunos.nome AS Nome_Aluno, turmas.descricao AS Turma, professores.nome AS Nome_Professor
FROM alunos
INNER JOIN turmas ON alunos.turma_id = turmas.turma_id
INNER JOIN turma_professor ON turmas.turma_id = turma_professor.turma_id
INNER JOIN professores ON turma_professor.professor_id = professores.professor_id;

SELECT Alunos.Nome, turmas.descricao
FROM Aluno
LEFT JOIN Turmas ON Alunos.turma_id  = Turmas.turma_id;

-- 2. exibir todos os professores e as turmas que eles lecionam 
-- incluindo professores que não lecionam nenhuma turmas

SELECT Professores.Nome, Turma.descricao
FROM Professores
LEFT JOIN Turma_Professor
ON Professores.professor_id = Turma_Professor.professor_id
LEFT JOIN Turmas ON Turma_professor.turma_id = Turmas.turma_id;

-- 3.Uma lista de todas as turmas e as atividades planejadas para elas 
-- mesmo que não haja atividades planejadas -- DICA => LEFT JOIN 

SELECT Turmas.descricao, atividades.descricao
FROM Turmas
LEFT JOIN atividades ON Turmas.turma_id = atividades.turma_id;

-- 4. Listar todos os alunos e suas notas na atividade de ID 1 mostrando alunos sem notas como NULL.

SELECT Alunos.nome, Nota.nota
FROM Alunos
LEFT JOIN Notas ON Alunos.aluno_id = Notas.aluno_id
AND Notas.atividades_id = 1;

-- 5. exibir todas as atividades junto com as notas dos alunos, mesmo que nenhuma nota tenha sido atribuida

SELECT Atividade.descricao, Alunos.nome, Notas.nota
FROM Atividades
RIGHT JOIN Notas ON Atividades.atividade_id = Noras.atividade_id
LEFT JOIN Alunos ON Notas.alunos_id = Alunos.aluno_id;

-- 6. Listar todas as notas e os respectivos nomes dos alunos, incluindo notas que não estão
-- associados a nenhum aluno

SELECT Alunos.Nome, Notas.nota
FROM Notas
RIGHT JOIN Alunos ON Notas.aluno_id = Alunos.aluno_id;
