use db_atividade_view;

-- 1. Exibir lista de alunos e seus cursos
create view alunos_compl as
select distinct aluno.nome as aluno, disciplina.nome as disciplina, curso.nome as curso
from matricula
inner join aluno on aluno.id_aluno = matricula.id_aluno
inner join disciplina on disciplina.id_disciplina = matricula.id_disciplina
inner join curso on curso.id_curso = disciplina.id_curso;

-- 2. Exibir total de alunos por disciplina
create view total_alunos as
select disciplina.nome as disciplina, count(aluno.id_aluno) as total_alunos
from matricula
inner join aluno on aluno.id_aluno = matricula.id_aluno
inner join disciplina on disciplina.id_disciplina = matricula.id_disciplina
group by disciplina.nome
;

-- 3. Exibir alunos e status das suas matrículas
create view status_disciplinas as
select aluno.nome as aluno, disciplina.nome as disciplina, matricula.status
from matricula
inner join aluno on aluno.id_aluno = matricula.id_aluno
inner join disciplina on disciplina.id_disciplina = matricula.id_disciplina
inner join curso on curso.id_curso = disciplina.id_curso;

-- 4. Exibir professores e suas turmas
create view professor_compl as
select professor.nome as professor, disciplina.nome as disciplina, turma.horario
from turma
inner join professor on professor.id_professor = turma.id_professor
inner join disciplina on disciplina.id_disciplina = turma.id_disciplina;

-- 5. Exibir alunos maiores de 20 anos
select nome, data_nascimento
from aluno
where (datediff(curdate(), data_nascimento) / 365) > 20;

-- 6. Exibir disciplinas e carga horária total por curso
create view curso_compl as
select curso.nome as curso, count(disciplina.id_disciplina) as total_disc, curso.carga_horaria
from curso
inner join disciplina on disciplina.id_curso = curso.id_curso
group by curso.nome, curso.carga_horaria;

-- 7. Exibir professores e suas especialidades
create view professor_esp as
select nome, especialidade
from professor;

-- 8. Exibir alunos matriculados em mais de uma disciplina
create view alunos_multidisciplina as
select aluno.nome
from matricula
inner join aluno on aluno.id_aluno = matricula.id_aluno
group by aluno.nome
having count(matricula.id_disciplina) > 1;

-- 9. Exibir alunos e o número de disciplinas que concluíram
create view concluidos as
select aluno.nome, count(matricula.status)
from matricula
inner join aluno on aluno.id_aluno = matricula.id_aluno
where matricula.status like ("C%")
group by aluno.nome;

-- 10. Exibir todas as turmas de um semestre específico
create view turmas_semestre as
select id_turma
from turma
where semestre like '2024.1';

-- 11. Exibir alunos com matrículas trancadas
create view trancadas as
select aluno.nome
from matricula
inner join aluno on aluno.id_aluno = matricula.id_aluno
where matricula.status like ("T%")
group by aluno.nome;

-- 12. Exibir disciplinas que não têm alunos matriculados
create view disc_sem_matriculas as
select disciplina.nome
from disciplina
left join matricula on matricula.id_disciplina = disciplina.id_disciplina
where matricula.id_disciplina is null;

-- 13. Exibir a quantidade de alunos por status de matrícula
create view controle_status_matricula as
select status, count(id_aluno) as qnt_aluno
from matricula
group by status;

-- 14. Exibir o total de professores por especialidade
create view controle_prof as
select especialidade, count(id_professor) as qnt_prof
from professor
group by especialidade;

-- 15. Exibir lista de alunos e suas idades
create view aluno_idade as
select nome, format((datediff(curdate(), data_nascimento) / 365), 0) as idade
from aluno;

-- 16. Exibir alunos e suas últimas matrículas
create view ultima_matricula_aluno as
select aluno.nome, max(matricula.data_matricula) as ult_matricula
from matricula
inner join aluno on aluno.id_aluno = matricula.id_aluno
group by aluno.nome;

-- 17. Exibir todas as disciplinas de um curso específico
create view disciplina_curso as
select disciplina.nome as disc, curso.nome as curso
from disciplina
inner join curso on curso.id_curso = disciplina.id_curso
where curso.nome like 'Engenharia de Software';

-- 18. Exibir os professores que não têm turmas
create view professores_sem_aula as
select professor.nome
from turma
left join professor on professor.id_professor = turma.id_professor
where professor.id_professor is null;

-- 19. Exibir lista de alunos com CPF e email
create view aluno_filtrada as
select nome, cpf, email
from aluno;

-- 20. Exibir o total de disciplinas por professor
create view qnt_disc_prof as
select professor.nome as professor, count(id_disciplina) as qnt_disc
from professor
inner join turma on turma.id_professor = professor.id_professor
group by professor.nome;
